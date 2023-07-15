Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 627DD7549B1
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jul 2023 17:12:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230090AbjGOPMX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 Jul 2023 11:12:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229574AbjGOPMV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Jul 2023 11:12:21 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63A5E30DF;
        Sat, 15 Jul 2023 08:12:13 -0700 (PDT)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36FF4oC7025343;
        Sat, 15 Jul 2023 15:12:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=UTLVMD5H2hQdXgJBEgpVsu+vOOSUGqFbFaRRrFxDZPU=;
 b=EP4nIxlmbgBVujNU69ow7n/TBKiVpeSxohetprIUQV0RMOeVXti2+ajta0UkX0/u6zr5
 Jsk4aUY9MUMmUPoEi2qnuG8hieuHYM8zipOq7wijPGA9rqFMq17kDiFiEGr/m/ZhMzQi
 1n0SdmiBRhoTm1R3jIz8ithnXyhzT2r2vQ3zeBnQsngUmnJWwzQE+Aq60sL7OXzu0ix3
 p/U0wPETYjn/Rf3gJ1VSuK5K+Y0rCno5G4o9WrOI+8jdP5jyCxsOxPzaJVWWhwjTvPh3
 QKpqQlwB7jNc0A89b4LTSyNdH4EPVJXXUg9DC+t7Po2AJQC2O7VMJZUxuTjsEcTYRnCx AA== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3run0c8fwx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 15 Jul 2023 15:12:07 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 36FFC6QT020749
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 15 Jul 2023 15:12:06 GMT
Received: from [10.216.17.249] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.30; Sat, 15 Jul
 2023 08:12:02 -0700
Message-ID: <dba8ab0a-c17b-8660-5c5a-803e7f394547@quicinc.com>
Date:   Sat, 15 Jul 2023 20:41:56 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.0
Subject: Re: [PATCH V2 1/2] dt-bindings: arm: qcom,ids: drop the IPQ5019 SoC
 ID
To:     Rob Herring <robh@kernel.org>
CC:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <quic_saahtoma@quicinc.com>
References: <20230712041912.398724-1-quic_kathirav@quicinc.com>
 <20230712041912.398724-2-quic_kathirav@quicinc.com>
 <20230714155954.GA3919199-robh@kernel.org>
Content-Language: en-US
From:   Kathiravan T <quic_kathirav@quicinc.com>
In-Reply-To: <20230714155954.GA3919199-robh@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: WOZ_kYRlbwCelxT7TKka1zp1Z_2gjxWm
X-Proofpoint-ORIG-GUID: WOZ_kYRlbwCelxT7TKka1zp1Z_2gjxWm
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-15_08,2023-07-13_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=857 spamscore=0
 priorityscore=1501 phishscore=0 malwarescore=0 suspectscore=0 bulkscore=0
 clxscore=1011 lowpriorityscore=0 impostorscore=0 mlxscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2306200000
 definitions=main-2307150143
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 7/14/2023 9:29 PM, Rob Herring wrote:
> On Wed, Jul 12, 2023 at 09:49:11AM +0530, Kathiravan T wrote:
>> IPQ5019 SoC is never productized. So lets drop it.
> You need to remove the user before removing the definition.


Rob, Currently there are no users for this macro.


>
>> Signed-off-by: Kathiravan T <quic_kathirav@quicinc.com>
>> ---
>> Changes in V2:
>> 	- Updated the commit message with the precise information for
>> 	  dropping this ID
>>
>>   include/dt-bindings/arm/qcom,ids.h | 1 -
>>   1 file changed, 1 deletion(-)
>>
>> diff --git a/include/dt-bindings/arm/qcom,ids.h b/include/dt-bindings/arm/qcom,ids.h
>> index bcbe9ee2cdaf..179dd56b2d95 100644
>> --- a/include/dt-bindings/arm/qcom,ids.h
>> +++ b/include/dt-bindings/arm/qcom,ids.h
>> @@ -250,7 +250,6 @@
>>   #define QCOM_ID_QRU1000			539
>>   #define QCOM_ID_QDU1000			545
>>   #define QCOM_ID_QDU1010			587
>> -#define QCOM_ID_IPQ5019			569
>>   #define QCOM_ID_QRU1032			588
>>   #define QCOM_ID_QRU1052			589
>>   #define QCOM_ID_QRU1062			590
>> -- 
>> 2.34.1
>>
