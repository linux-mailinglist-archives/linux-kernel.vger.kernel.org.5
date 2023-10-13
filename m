Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 515977C7D1A
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Oct 2023 07:41:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229661AbjJMFlr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Oct 2023 01:41:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjJMFlq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Oct 2023 01:41:46 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CA98B7;
        Thu, 12 Oct 2023 22:41:44 -0700 (PDT)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39D2iG5E009646;
        Fri, 13 Oct 2023 05:41:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=k7srpVrEMj0jtruEIJpxYUZScvzOnfM7JeWmVEFFr2U=;
 b=lpcjn1XJ2XPvk3Qoi+J3yETVKyweKrX755xZtx0LaKkGT36cVoKreyaFl+M4yFE+ibo4
 D0IdtsMZzrtJBFD9chNMVLcq8es0054KlludOkaIQTFoGp08RWwYeoH99itD8Qm0AOkW
 jGRY9Q9WeuQ2N+B2/YNvD1iPdggmUmwN9Eh+eV7KIqxRxWsud9Uoxdcj7JJloQvZZe1M
 AaGj8F4kEWnGqcA4kcb91y6DpvG1lEi1SetMkeUcIGrlEwH4h1L1OtW1cz4gZflIIehQ
 SYrkMGprEpMgx/ECV7TKa2fhKNldR0Ff/4WZhdIr/20I9uH+asAi12AzfvH8y11c3Ile xw== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3tpt1u8nt2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 13 Oct 2023 05:41:38 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 39D5fAYU029856
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 13 Oct 2023 05:41:10 GMT
Received: from [10.214.67.128] (10.80.80.8) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.30; Thu, 12 Oct
 2023 22:41:06 -0700
Message-ID: <994a6ff0-9b6c-0ac8-9a6c-694a2abd0f4d@quicinc.com>
Date:   Fri, 13 Oct 2023 11:11:00 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH v3 2/2] arm64: dts: qcom: qcm6490: Add qcm6490 dts file
Content-Language: en-US
To:     Konrad Dybcio <konrad.dybcio@linaro.org>, <agross@kernel.org>,
        <andersson@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>
CC:     <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <luca.weiss@fairphone.com>
References: <20231003175456.14774-1-quic_kbajaj@quicinc.com>
 <20231003175456.14774-3-quic_kbajaj@quicinc.com>
 <e846215b-faba-4af6-a108-bae9b1deb2be@linaro.org>
From:   Komal Bajaj <quic_kbajaj@quicinc.com>
In-Reply-To: <e846215b-faba-4af6-a108-bae9b1deb2be@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: Bdgp0tnyLPhoGmyKiLzGk3GKDixczKwO
X-Proofpoint-ORIG-GUID: Bdgp0tnyLPhoGmyKiLzGk3GKDixczKwO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-13_03,2023-10-12_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 lowpriorityscore=0 phishscore=0 mlxlogscore=933 clxscore=1011 adultscore=0
 malwarescore=0 bulkscore=0 impostorscore=0 mlxscore=0 suspectscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2309180000 definitions=main-2310130049
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/7/2023 5:03 AM, Konrad Dybcio wrote:
> On 3.10.2023 19:54, Komal Bajaj wrote:
>> Add qcm6490 devicetree file for QCM6490 SoC and QCM6490 IDP
>> platform. QCM6490 is derived from SC7280 meant for various
>> form factor including IoT.
>>
>> Supported features are, as of now:
>> * Debug UART
>> * eMMC
>> * USB
>>
>> Signed-off-by: Komal Bajaj <quic_kbajaj@quicinc.com>
>> ---
>>   arch/arm64/boot/dts/qcom/Makefile        |   1 +
>>   arch/arm64/boot/dts/qcom/qcm6490-idp.dts | 333 +++++++++++++++++++++++
>>   arch/arm64/boot/dts/qcom/qcm6490.dtsi    |  94 +++++++
>>   3 files changed, 428 insertions(+)
>>   create mode 100644 arch/arm64/boot/dts/qcom/qcm6490-idp.dts
>>   create mode 100644 arch/arm64/boot/dts/qcom/qcm6490.dtsi
>>
>> diff --git a/arch/arm64/boot/dts/qcom/Makefile b/arch/arm64/boot/dts/qcom/Makefile
>> index 73c3be0f8872..3a2d9dbaacce 100644
>> --- a/arch/arm64/boot/dts/qcom/Makefile
>> +++ b/arch/arm64/boot/dts/qcom/Makefile
>> @@ -82,6 +82,7 @@ dtb-$(CONFIG_ARCH_QCOM)	+= msm8998-sony-xperia-yoshino-maple.dtb
>>   dtb-$(CONFIG_ARCH_QCOM)	+= msm8998-sony-xperia-yoshino-poplar.dtb
>>   dtb-$(CONFIG_ARCH_QCOM)	+= msm8998-xiaomi-sagit.dtb
>>   dtb-$(CONFIG_ARCH_QCOM)	+= qcm6490-fairphone-fp5.dtb
>> +dtb-$(CONFIG_ARCH_QCOM)	+= qcm6490-idp.dtb
>>   dtb-$(CONFIG_ARCH_QCOM)	+= qcs404-evb-1000.dtb
>>   dtb-$(CONFIG_ARCH_QCOM)	+= qcs404-evb-4000.dtb
>>   dtb-$(CONFIG_ARCH_QCOM)	+= qdu1000-idp.dtb
>> diff --git a/arch/arm64/boot/dts/qcom/qcm6490-idp.dts b/arch/arm64/boot/dts/qcom/qcm6490-idp.dts
>> new file mode 100644
>> index 000000000000..d81a7810fd5a
>> --- /dev/null
>> +++ b/arch/arm64/boot/dts/qcom/qcm6490-idp.dts
>> @@ -0,0 +1,333 @@
>> +// SPDX-License-Identifier: BSD-3-Clause
>> +/*
>> + * Copyright (c) 2023 Qualcomm Innovation Center, Inc. All rights reserved.
>> + */
>> +
>> +/dts-v1/;
>> +
>> +#include <dt-bindings/iio/qcom,spmi-adc7-pmk8350.h>
>> +#include <dt-bindings/regulator/qcom,rpmh-regulator.h>
>> +#include "pm7325.dtsi"
>> +#include "pm8350c.dtsi"
>> +#include "pmk8350.dtsi"
>> +#include "qcm6490.dtsi"
> As the kernel robot pointed out, this has clearly not even been
> compile-tested..

Sorry for this.. I made this change as per the comment that I got to 
sort the
inclusion files in alphabetical order. Incremental build compilation 
wasn't able
to catch this error.
I will move qcm6490.dtsi file inclusion before pm* files inclusion.

Thanks
Komal

>
> Konrad

