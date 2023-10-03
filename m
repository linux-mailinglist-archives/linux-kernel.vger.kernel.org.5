Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8751A7B603A
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 07:09:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230200AbjJCFJg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 01:09:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230049AbjJCFJf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 01:09:35 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 042DFA9;
        Mon,  2 Oct 2023 22:09:32 -0700 (PDT)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3934JecJ024965;
        Tue, 3 Oct 2023 05:09:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=APyqbOeY3JUwP/mrqXaV6eKWfacch9S+zZjNV+vSlp0=;
 b=SPDdo8fu7r5gVFtBJzWI1jOy/XMrpnZy9sndipRxr5e/vr1TMFOUzuoJ3wc6qmO/Pkp9
 W+qe2CdsnBpYKP6Vlurwo8zCRaamdIERTPXuwgTCrBXUvq26F1r5hitkAxMC8RfrbroX
 sjq+4XXk0TY3RcwyawptRh4+IriuhJjTPrW9aeTmUOBkf8dlr8MEKtIRR5Ea4ddwQq+b
 1oVwiXmbTM9t2hN6EJ0vsckC3H6VIo3knvk3VxkRKIO9t6ky24LuEtwuE5+iYeZyF4LA
 wsqXOSTyJQES8qHEj3BBkRoWaaETa+4SyM8YxT7/5K9QpT1SSbp21Vwd7PA7CQ7dG9E2 lA== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3tgbjkg39a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 03 Oct 2023 05:09:26 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 39359Ap8006230
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 3 Oct 2023 05:09:10 GMT
Received: from [10.216.33.128] (10.80.80.8) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.30; Mon, 2 Oct
 2023 22:09:06 -0700
Message-ID: <eaf9759c-946b-a2fd-042d-235709201908@quicinc.com>
Date:   Tue, 3 Oct 2023 10:39:02 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH] dt-bindings: arm: qcom: drop the IPQ board types
Content-Language: en-US
To:     Bryan O'Donoghue <bryan.odonoghue@linaro.org>, <agross@kernel.org>,
        <andersson@kernel.org>, <konrad.dybcio@linaro.org>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <conor+dt@kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20230927093130.4098385-1-quic_sridsn@quicinc.com>
 <3b7a6266-e2fc-4b56-8b41-a26042248c64@linaro.org>
From:   Sridharan S N <quic_sridsn@quicinc.com>
In-Reply-To: <3b7a6266-e2fc-4b56-8b41-a26042248c64@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: y4kYZUoYcOqwTzT9s0RmF-rVO9o4g1cJ
X-Proofpoint-GUID: y4kYZUoYcOqwTzT9s0RmF-rVO9o4g1cJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-03_02,2023-10-02_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 bulkscore=0
 impostorscore=0 lowpriorityscore=0 mlxlogscore=877 spamscore=0
 malwarescore=0 clxscore=1015 priorityscore=1501 mlxscore=0 adultscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2309180000 definitions=main-2310030041
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 9/27/2023 5:01 PM, Bryan O'Donoghue wrote:
> On 27/09/2023 10:31, Sridharan S N wrote:
>> IPQ bootloaders do not need these information to select the
>> the DTB blob. So dropping the board names from board section.
>>
>> Signed-off-by: Sridharan S N <quic_sridsn@quicinc.com>
>> ---
>>   Documentation/devicetree/bindings/arm/qcom.yaml | 14 --------------
>>   1 file changed, 14 deletions(-)
>>
>> diff --git a/Documentation/devicetree/bindings/arm/qcom.yaml 
>> b/Documentation/devicetree/bindings/arm/qcom.yaml
>> index 7f80f48a0954..5b56f3d90d4d 100644
>> --- a/Documentation/devicetree/bindings/arm/qcom.yaml
>> +++ b/Documentation/devicetree/bindings/arm/qcom.yaml
>> @@ -91,24 +91,10 @@ description: |
>>     The 'board' element must be one of the following strings:
>>             adp
>> -        ap-al02-c2
>> -        ap-al02-c6
>> -        ap-al02-c7
>> -        ap-al02-c8
>> -        ap-al02-c9
>> -        ap-mi01.2
>> -        ap-mi01.3
>> -        ap-mi01.6
>> -        ap-mi01.9
>>           cdp
>> -        cp01-c1
>>           dragonboard
>> -        hk01
>> -        hk10-c1
>> -        hk10-c2
>>           idp
>>           liquid
>> -        rdp432-c2
>>           mtp
>>           qrd
>>           rb2
>
> All bootloaders ? You are 100% sure that all versions of downstream 
> u-boot don't rely on these strings ? Upstream u-boot too ?
>
> ---
> bod

Yes , we don't rely on these strings , instead downstream u-boot uses 
machid to identify the DTB.

Thanks,

Sridharan S N

