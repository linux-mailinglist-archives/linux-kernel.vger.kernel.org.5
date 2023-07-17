Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9EB707563B7
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 15:03:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230428AbjGQNDQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 09:03:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231453AbjGQNDB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 09:03:01 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54584E9;
        Mon, 17 Jul 2023 06:02:57 -0700 (PDT)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36HCJxDV001763;
        Mon, 17 Jul 2023 13:02:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=yYtFwNmcp0VoC/EQ9EboRRHyALSnxvXREmvSWbWPUm4=;
 b=mg+yxvgh1eDdVpeCNA0gH480QodIv5Cww4HwMTLU4XRYBIy5CVuy4bbMTzvzIivduIiL
 YGDME8P9EsO8xHooA/h7giBuAFdMyErhVpI4YvlIiIUT9qbMwWvLu4fq0VzhQnjeLiAw
 bO1AUEJfBfPQ7uuTWjX8WltRssbG3JDjDyq3LASC2rIdGTJpoQT8EmuGFdDdSUT6eD0d
 1jFZOCblJ3M+LAQvDN3r6wo4nFf+736qb+zH8fSne2+Mr9/uU1FUU1eN7xiXVTpa3MAn
 mJ8DOd9h65A3fmoj8uDEEfhXICJSFIUqhJazlbf086mrB5L7IXj8svzpqMw9nHDYSzS0 6Q== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3run09uj9y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 17 Jul 2023 13:02:51 +0000
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 36HD2nKX030296
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 17 Jul 2023 13:02:49 GMT
Received: from [10.214.67.128] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.30; Mon, 17 Jul
 2023 06:02:46 -0700
Message-ID: <7c09054a-aac4-8b8f-8e13-421925f7f5c0@quicinc.com>
Date:   Mon, 17 Jul 2023 18:32:41 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH v3 1/2] arm64: dts: qcom: qdu1000-idp: Update reserved
 memory region
Content-Language: en-US
To:     Konrad Dybcio <konrad.dybcio@linaro.org>, <agross@kernel.org>,
        <andersson@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>
CC:     <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20230706125129.20969-1-quic_kbajaj@quicinc.com>
 <20230706125129.20969-2-quic_kbajaj@quicinc.com>
 <bb80d65e-b6e5-37ac-b4eb-01166af6f39c@linaro.org>
From:   Komal Bajaj <quic_kbajaj@quicinc.com>
In-Reply-To: <bb80d65e-b6e5-37ac-b4eb-01166af6f39c@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: OTxUay0SUCZ8OJLz6pzNddb6zfUfLBE5
X-Proofpoint-GUID: OTxUay0SUCZ8OJLz6pzNddb6zfUfLBE5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-17_09,2023-07-13_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501 mlxscore=0
 phishscore=0 mlxlogscore=694 lowpriorityscore=0 adultscore=0
 suspectscore=0 spamscore=0 bulkscore=0 malwarescore=0 impostorscore=0
 clxscore=1011 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2307170118
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/15/2023 7:43 PM, Konrad Dybcio wrote:
> On 6.07.2023 14:51, Komal Bajaj wrote:
>> Add missing reserved regions as described in QDU1000 memory map.
>>
>> Signed-off-by: Komal Bajaj <quic_kbajaj@quicinc.com>
>> ---
> Are you sure you want to reserve 4352 MiB?

Yes, we want to reserve 4352 MiB of memory here, since this SoC enables 
Open RAN solution, it requires such huge
memory for its modem usecase.

Thanks
Komal

>
> Konrad
>>   arch/arm64/boot/dts/qcom/qdu1000-idp.dts | 22 ++++++++++++++++++++++
>>   1 file changed, 22 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/qcom/qdu1000-idp.dts b/arch/arm64/boot/dts/qcom/qdu1000-idp.dts
>> index 1d22f87fd238..8446eb438a34 100644
>> --- a/arch/arm64/boot/dts/qcom/qdu1000-idp.dts
>> +++ b/arch/arm64/boot/dts/qcom/qdu1000-idp.dts
>> @@ -448,6 +448,28 @@ &qupv3_id_0 {
>>   	status = "okay";
>>   };
>>
>> +&reserved_memory {
>> +	ecc_meta_data_mem: ecc-meta-data@e0000000 {
>> +		reg = <0x0 0xe0000000 0x0 0x20000000>;
>> +		no-map;
>> +	};
>> +
>> +	harq_buffer_mem: harq-buffer@800000000 {
>> +		reg = <0x8 0x0 0x0 0x80000000>;
>> +		no-map;
>> +	};
>> +
>> +	tenx_sp_buffer_mem: tenx-sp-buffer@880000000 {
>> +		reg = <0x8 0x80000000 0x0 0x50000000>;
>> +		no-map;
>> +	};
>> +
>> +	fapi_buffer_mem: fapi-buffer@8d0000000 {
>> +		reg = <0x8 0xd0000000 0x0 0x20000000>;
>> +		no-map;
>> +	};
>> +};
>> +
>>   &sdhc {
>>   	pinctrl-0 = <&sdc_on_state>;
>>   	pinctrl-1 = <&sdc_off_state>;
>> --
>> 2.40.1
>>

