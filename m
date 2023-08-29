Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B82B78BE39
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 08:06:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231325AbjH2GFb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 02:05:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230419AbjH2GE7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 02:04:59 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72C71124;
        Mon, 28 Aug 2023 23:04:56 -0700 (PDT)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37T3r3KX029478;
        Tue, 29 Aug 2023 06:04:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=AY53HRio7ozx2cEiP/KIfeRfm92C+XzhK+j9U3BAg0s=;
 b=I+VbcKfFfZhRg5827GipBU9izYh8plc9bTvZzzP3qV5MDxK2LYxnrMcebWtHSOSpk1/t
 DnWkldo0DzrqqbjBsL/8hS1fts8byXPoPJzpDjDZQlaWO5ScBUvMpIhz9sOGPt/9lMLD
 dXEZWPv6yVxuexKgi6QivpcMYmVafFFcZZDI0yuDzCMSkWJwlvFEOosSJFFN22k6Jz37
 Y84LCgZaTla2DaCvR5F2gNSLDkCMh1uzlUcNOs2Ca7WdNfXoyHdbA6kwacd4DjLfN/m3
 hMGZtcE2eikHcd0QWMLGMfUYX9eB21FDAA/WEWVy5eJiaRpH6cq3e0W348ficqGjn28A Mw== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3ss4g6ghqr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 29 Aug 2023 06:04:52 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 37T64pwt017293
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 29 Aug 2023 06:04:51 GMT
Received: from [10.216.63.45] (10.80.80.8) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.30; Mon, 28 Aug
 2023 23:04:46 -0700
Message-ID: <56a62c14-7cfa-ca63-0c5a-c4f7fe05d6ba@quicinc.com>
Date:   Tue, 29 Aug 2023 11:34:42 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH 6/7] arm64: dts: qcom: ipq5018: Add tsens node
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <srinivas.kandagatla@linaro.org>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <conor+dt@kernel.org>, <thara.gopinath@gmail.com>,
        <rafael@kernel.org>, <daniel.lezcano@linaro.org>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-pm@vger.kernel.org>
References: <1693250307-8910-1-git-send-email-quic_srichara@quicinc.com>
 <1693250307-8910-7-git-send-email-quic_srichara@quicinc.com>
 <75ca0f84-3aa7-aead-fc99-d72e46c6b711@linaro.org>
From:   Sricharan Ramabadhran <quic_srichara@quicinc.com>
In-Reply-To: <75ca0f84-3aa7-aead-fc99-d72e46c6b711@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: u02sGpvma5k2s-nQUTXVovR3wERf5jS7
X-Proofpoint-GUID: u02sGpvma5k2s-nQUTXVovR3wERf5jS7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-29_03,2023-08-28_04,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 priorityscore=1501 mlxscore=0 mlxlogscore=999 malwarescore=0
 lowpriorityscore=0 phishscore=0 clxscore=1015 spamscore=0 bulkscore=0
 adultscore=0 suspectscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2308100000 definitions=main-2308290051
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/29/2023 12:55 AM, Krzysztof Kozlowski wrote:
> On 28/08/2023 21:18, Sricharan Ramabadhran wrote:
>> IPQ5018 has tsens V1.0 IP with 4 sensors.
>> There is no RPM, so tsens has to manually enabled.
>> Adding the tsens and nvmem node.
>>
>> Signed-off-by: Sricharan Ramabadhran <quic_srichara@quicinc.com>
>> ---
>>   arch/arm64/boot/dts/qcom/ipq5018.dtsi | 23 +++++++++++++++++++++++
>>   1 file changed, 23 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/qcom/ipq5018.dtsi b/arch/arm64/boot/dts/qcom/ipq5018.dtsi
>> index 9f13d2dcdfd5..277b3cfc7f72 100644
>> --- a/arch/arm64/boot/dts/qcom/ipq5018.dtsi
>> +++ b/arch/arm64/boot/dts/qcom/ipq5018.dtsi
>> @@ -93,6 +93,29 @@ soc: soc@0 {
>>   		#size-cells = <1>;
>>   		ranges = <0 0 0 0xffffffff>;
>>   
>> +		qfprom_nvmem: qfprom_nvmem@a0000 {
> 
> Nope. Come on, where do you see such node naming. Please do not send
> code from downstream, but work on upstream sources. Open other most
> recent DTS, take a look how it is done and try to do something similar.
> 

  sure, will fix it up.
>> +			#address-cells = <1>;
>> +			#size-cells = <1>;
> 
> compatible is always the first property. Then reg.

  ok, will fix.

Regards,
  Sricharan
