Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83A857BA236
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Oct 2023 17:21:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232168AbjJEPVU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Oct 2023 11:21:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232405AbjJEPUU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Oct 2023 11:20:20 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C99B17ECB;
        Thu,  5 Oct 2023 06:56:17 -0700 (PDT)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3959wOMw017759;
        Thu, 5 Oct 2023 13:56:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : from : to : references : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=mhWtRwSrCBHkhnh4SbONgAeq/8iY4hKQg3DZnXzzILU=;
 b=Pa3Fhy6wrqBsyY+/r23GuMzat9EhPFHmiOSQTEhM/9BMsTNjRW1SQKYCW4FrAeIGt6YL
 bSPS//umUmspE9u+83VcTvsZneHAj37bVSImZiwFf7G4Y8cMxD28NcUHhmVWn2PQGt9a
 hINy/PtN5PV7Sx/UN5PrySNEMgxBvBPpnFmB3dPUR6bgoeyAOjbdC1nWpXdQXvo9yJvp
 Lz48KIgF17hDu9+x/SBwohHSmz3Vkmbhz6JYTJ9+e5UhJm1oHKDavYDFlzwGvEILNomm
 EHqot3mja+0uCMJC3Vdim4yDsGj+CTqqpQ14wwVHfFbT3L+37XT/m4cHAwRTMAa/FbAR Ag== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3thnfa90b9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 05 Oct 2023 13:56:10 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 395Du9rs004252
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 5 Oct 2023 13:56:09 GMT
Received: from [10.216.12.172] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.36; Thu, 5 Oct
 2023 06:56:04 -0700
Message-ID: <416692f7-ffeb-419b-9a05-24909ab13de9@quicinc.com>
Date:   Thu, 5 Oct 2023 19:25:59 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: dts: qcom: ipq5018: add QUP1 SPI controller
Content-Language: en-US
From:   Kathiravan Thirumoorthy <quic_kathirav@quicinc.com>
To:     Robert Marko <robimarko@gmail.com>, <agross@kernel.org>,
        <andersson@kernel.org>, <konrad.dybcio@linaro.org>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <conor+dt@kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20231004191303.331055-1-robimarko@gmail.com>
 <6dcb61f6-9be4-4feb-a7dd-44d606fcc480@quicinc.com>
In-Reply-To: <6dcb61f6-9be4-4feb-a7dd-44d606fcc480@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: hGgLs-_VgMRTSWpTO1lae4jKgHpvkrLA
X-Proofpoint-ORIG-GUID: hGgLs-_VgMRTSWpTO1lae4jKgHpvkrLA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-05_08,2023-10-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 lowpriorityscore=0 mlxlogscore=991 malwarescore=0 bulkscore=0 spamscore=0
 impostorscore=0 clxscore=1015 adultscore=0 phishscore=0 mlxscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2309180000 definitions=main-2310050108
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 10/5/2023 7:18 PM, Kathiravan Thirumoorthy wrote:
>
> On 10/5/2023 12:42 AM, Robert Marko wrote:
>> Add the required BAM and QUP nodes for the QUP1 SPI controller on 
>> IPQ5018.
>>
>> Signed-off-by: Robert Marko <robimarko@gmail.com>
>> ---
>>   arch/arm64/boot/dts/qcom/ipq5018.dtsi | 24 ++++++++++++++++++++++++
>>   1 file changed, 24 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/qcom/ipq5018.dtsi 
>> b/arch/arm64/boot/dts/qcom/ipq5018.dtsi
>> index 38ffdc3cbdcd..484034e65f4f 100644
>> --- a/arch/arm64/boot/dts/qcom/ipq5018.dtsi
>> +++ b/arch/arm64/boot/dts/qcom/ipq5018.dtsi
>> @@ -146,6 +146,16 @@ sdhc_1: mmc@7804000 {
>>               status = "disabled";
>>           };
>>   +        blsp_dma: dma-controller@7884000 {
>> +            compatible = "qcom,bam-v1.7.0";
>> +            reg = <0x07884000 0x1d000>;
>> +            interrupts = <GIC_SPI 238 IRQ_TYPE_LEVEL_HIGH>;
>> +            clocks = <&gcc GCC_BLSP1_AHB_CLK>;
>> +            clock-names = "bam_clk";
>> +            #dma-cells = <1>;
>> +            qcom,ee = <0>;
>> +        };
>> +
>>           blsp1_uart1: serial@78af000 {
>>               compatible = "qcom,msm-uartdm-v1.4", "qcom,msm-uartdm";
>>               reg = <0x078af000 0x200>;
>> @@ -156,6 +166,20 @@ blsp1_uart1: serial@78af000 {
>>               status = "disabled";
>>           };
>>   +        blsp1_spi1: spi@78b5000 {
>> +            compatible = "qcom,spi-qup-v2.2.1";
>> +            #address-cells = <1>;
>> +            #size-cells = <0>;
>> +            reg = <0x78b5000 0x600>;
>
>
> Please pad the address part to 8 hex digits with leading zeroes. With 
> that,
>
> Reviewed-by: Kathiravan T <quic_kathirav@quicinc.com>

Once again, missed to spell out last name...

Reviewed-by: Kathiravan Thirumoorthy <quic_kathirav@quicinc.com>


>
>
>> +            interrupts = <GIC_SPI 95 IRQ_TYPE_LEVEL_HIGH>;
>> +            clocks = <&gcc GCC_BLSP1_QUP1_SPI_APPS_CLK>,
>> +                 <&gcc GCC_BLSP1_AHB_CLK>;
>> +            clock-names = "core", "iface";
>> +            dmas = <&blsp_dma 4>, <&blsp_dma 5>;
>> +            dma-names = "tx", "rx";
>> +            status = "disabled";
>> +        };
>> +
>>           intc: interrupt-controller@b000000 {
>>               compatible = "qcom,msm-qgic2";
>>               reg = <0x0b000000 0x1000>,  /* GICD */
