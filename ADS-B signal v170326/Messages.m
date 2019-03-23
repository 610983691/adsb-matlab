classdef Messages < handle
    %MESSAGE Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        txTimeSeries
        rxTimeSeries
        plane
        type
        
        traceSeries
        
        txPower   %dBm
        rxPower   %dBm
        rxFrqOffset
        bitStream
        
        
    end
    
    methods
        function obj = Messages(plane,txTimeSeries,typeSeries)
            obj.plane=plane;
            obj.txTimeSeries=reshape(txTimeSeries,length(txTimeSeries),1);
            obj.type=reshape(typeSeries,length(typeSeries),1);
            
            obj.traceSeries = plane.getTraceSeries(txTimeSeries);
            
            obj.txPower=plane.txPower;
            
            
        end
        
        function obj = setRxFrqOffset(obj,rxFrqOffset)
            obj.rxFrqOffset = rxFrqOffset;
        end
        function txFrqOffset = getTxFrqOffset(obj)
            txFrqOffset = obj.plane.frqOffset;
        end
        
        function traceSeries = getTraceSeries(obj)
            traceSeries = obj.traceSeries;
        end
        function txTimeSeries = getTxTimeSeries(obj)
            txTimeSeries = obj.txTimeSeries;
        end
        
        function obj = setRxTimeSeries(obj,rxTimeSeries)
            obj.rxTimeSeries = reshape(rxTimeSeries,length(rxTimeSeries),1);
        end
        function obj = setGainSeries(obj,gainSereis)
            obj.rxPower = obj.txPower-reshape(gainSereis,length(gainSereis),1);
        end
        
        function obj = setBitStreams(obj,bitStream)
            obj.bitStream = bitStream;
        end
        function bitStream = getBitStream(obj,index)
            bitStream = obj.bitStream(index,:);
        end
    end
    
end

