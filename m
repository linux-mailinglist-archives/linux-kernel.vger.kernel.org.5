Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 622727B3118
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Sep 2023 13:12:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232902AbjI2LMe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Sep 2023 07:12:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229687AbjI2LMb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Sep 2023 07:12:31 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7535DE;
        Fri, 29 Sep 2023 04:12:28 -0700 (PDT)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38TAYJ66020854;
        Fri, 29 Sep 2023 11:12:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=MsNaE9xqvzznArDpHPloWifAkNdpAv7hH6E/eAiBykM=;
 b=DK0RzNYp90AwC3H77YYfOWRaKeGdwjueW2r1vZOg2gGpt/go1aosYXgdf9MUu/Zj3UC+
 jxftg0TYEAT3R9UYZAyvRkXLqqCGXKcFsNIJ6vooEg54xKwckZ8wK6MBHjr4sHvOLgHT
 WUliq6GjafEZvPS+EzLZ0+BVEQNZuU9odUG6ps/1LsmNLzhXmPeFymAFOE5mqbvd5VoB
 DQm6tIRWcuuZFmegRjykAEGCtNQ1gT8FZdtWw6zg3QXZCJTiwmR39CCIETBkDPxbphyv
 J+/J/XEAc6HbYrrhH8PgS434OAq3fdJeDFujSO0mDXclI8ndi/VYiK7W+LNKjfiJuPyK lg== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3tda4c25j5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 29 Sep 2023 11:12:23 +0000
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 38TBCMrX018345
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 29 Sep 2023 11:12:22 GMT
Received: from [10.214.67.128] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.36; Fri, 29 Sep
 2023 04:12:18 -0700
Message-ID: <dc3dd045-27d4-b684-e812-dc95faf0df50@quicinc.com>
Date:   Fri, 29 Sep 2023 16:42:15 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH 2/2] arm64: dts: qcom: qcm6490: Add qcm6490 dts file
Content-Language: en-US
To:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
CC:     <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Luca Weiss <luca.weiss@fairphone.com>
References: <20230928133312.11371-1-quic_kbajaj@quicinc.com>
 <20230928133312.11371-3-quic_kbajaj@quicinc.com>
 <661bd908-a056-4d46-97a3-d3b12b14c050@linaro.org>
From:   Komal Bajaj <quic_kbajaj@quicinc.com>
In-Reply-To: <661bd908-a056-4d46-97a3-d3b12b14c050@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: oLK0VdOTMfG83n2XddiRXGOLsZcDFtLF
X-Proofpoint-ORIG-GUID: oLK0VdOTMfG83n2XddiRXGOLsZcDFtLF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-09-29_09,2023-09-28_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 phishscore=0
 mlxlogscore=999 lowpriorityscore=0 spamscore=0 adultscore=0 bulkscore=0
 priorityscore=1501 clxscore=1015 mlxscore=0 impostorscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2309180000
 definitions=main-2309290095
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/28/2023 7:16 PM, Konrad Dybcio wrote:
> On 28.09.2023 15:33, Komal Bajaj wrote:
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
> [...]
>
>> +/ {
>> +	model = "Qualcomm Technologies, Inc. QCM6490 IDP platform";
> Isomething Development Platform platform?

Will drop suffix platform.

>
>> +	compatible = "qcom,qcm6490-idp", "qcom,qcm6490";
>> +
>> +	aliases {
>> +		serial0 = &uart5;
>> +	};
>> +
>> +	chosen {
>> +		stdout-path = "serial0:115200n8";
>> +	};
>> +
>> +};
> Stray newline above

Noted.

>
>> +
>> +&apps_rsc {
>> +	regulators-0 {
>> +		compatible = "qcom,pm7325-rpmh-regulators";
>> +		qcom,pmic-id = "b";
>> +
>> +		vreg_s1b_1p8: smps1 {
>> +			regulator-min-microvolt = <1856000>;
>> +			regulator-max-microvolt = <2040000>;
> Hm, you didn't specify regulator-initial-mode on any vregs

Okay, will specify it in next patchset.

>
> [...]
>
>> --- /dev/null
>> +++ b/arch/arm64/boot/dts/qcom/qcm6490.dtsi
>> @@ -0,0 +1,137 @@
>> +// SPDX-License-Identifier: BSD-3-Clause
>> +/*
>> + * Copyright (c) 2023 Qualcomm Innovation Center, Inc. All rights reserved.
>> + */
>> +
>> +#include "sc7280.dtsi"
>> +
>> +/*
>> + * Delete sc7280 lpass related nodes as qcm6490 intends to move away from
>> + * bypass configuration
>> + */
>> +/delete-node/ &lpass_ag_noc;
>> +/delete-node/ &lpass_aon;
>> +/delete-node/ &lpass_audiocc;
>> +/delete-node/ &lpass_core;
>> +/delete-node/ &lpass_cpu;
>> +/delete-node/ &lpass_hm;
>> +/delete-node/ &lpass_rx_macro;
>> +/delete-node/ &lpass_tx_macro;
>> +/delete-node/ &lpass_va_macro;
>> +/delete-node/ &lpass_tlmm;
>> +/delete-node/ &lpasscc;
>> +/delete-node/ &swr0;
>> +/delete-node/ &swr1;
> That's very unnecessary, most of these nodes are in use even
> when routing audio through ADSP.
>
> Ones that are not, are set to status = "reserved" and some
> will need more work to function based on the configuration.
>
> There was once a series from somebody at qc to introduce ADSP
> audio on 7280, but it was full of hacks and NAKed

Seeking clarification which nodes will be used and which should be disabled.
For now, will remove it.

>
>
>> +
>> +/*
>> + * Delete unused sc7280 memory nodes and define the memory regions
>> + * required by qcm6490
>> + */
> That's specific to your board.

No, these are not board specific, it's soc specific.

>
>> +/delete-node/ &rmtfs_mem;
>> +/delete-node/ &wlan_ce_mem;
>> +
>> +/{
>> +	reserved-memory {
>> +		secdata_apss_mem: secdata-apss@808ff000 {
>> +			reg = <0x0 0x808ff000 0x0 0x1000>;
>> +			no-map;
>> +		};
> This is identical to the entry in sc7280.dtsi.

Yeah, right. Will remove it.

>
>> +
>> +		cdsp_secure_heap_mem: cdsp-secure-heap@81800000 {
>> +			reg = <0x0 0x81800000 0x0 0x1e00000>;
>> +			no-map;
>> +		};
>> +
>> +		camera_mem: camera@84300000 {
>> +			reg = <0x0 0x84300000 0x0 0x500000>;
>> +			no-map;
>> +		};
>> +
>> +		adsp_mem: adsp@86100000 {
>> +			reg = <0x0 0x86100000 0x0 0x2800000>;
>> +			no-map;
>> +		};
>> +
>> +		cdsp_mem: cdsp@88900000 {
>> +			reg = <0x0 0x88900000 0x0 0x1e00000>;
>> +			no-map;
>> +		};
>> +
>> +		cvp_mem: cvp@8ac00000 {
>> +			reg = <0x0 0x8ac00000 0x0 0x500000>;
>> +			no-map;
>> +		};
>> +
>> +		ipa_gsi_mem: ipa-gsi@8b110000 {
>> +			reg = <0x0 0x8b110000 0x0 0xa000>;
>> +			no-map;
>> +		};
>> +
>> +		gpu_microcode_mem: gpu-microcode@8b11a000 {
>> +			reg = <0x0 0x8b11a000 0x0 0x2000>;
>> +			no-map;
>> +		};
>> +
>> +		mpss_mem: mpss@8b800000 {
>> +			reg = <0x0 0x8b800000 0x0 0xf600000>;
>> +			no-map;
>> +		};
>> +
>> +		wpss_mem: wpss@9ae00000 {
>> +			reg = <0x0 0x9ae00000 0x0 0x1900000>;
>> +			no-map;
>> +		};
> This entry is in both chrome-common and fairphone (meaning all boards
> use it), perhaps this one could be moved to 7280.dtsi

Missed to update region for wpss_mem. It's different what's used in 
chrome-common and fairphone.

>
>> +
>> +		tz_stat_mem: tz-stat@c0000000 {
>> +			reg = <0x0 0xc0000000 0x0 0x100000>;
>> +			no-map;
>> +		};
>> +
>> +		tags_mem: tags@c0100000 {
>> +			reg = <0x0 0xc0100000 0x0 0x1200000>;
>> +			no-map;
>> +		};
>> +
>> +		qtee_mem: qtee@c1300000 {
>> +			reg = <0x0 0xc1300000 0x0 0x500000>;
>> +			no-map;
>> +		};
>> +
>> +		trusted_apps_mem: trusted_apps@c1800000 {
>> +			reg = <0x0 0xc1800000 0x0 0x3900000>;
>> +			no-map;
>> +		};
>> +	};
>> +};
>> +
>> +&hyp_mem {
>> +	reg = <0x0 0x80000000 0x0 0x600000>;
> This is identical to the entry in sc7280.dtsi.

Will remove it.

>
>> +};
>> +
>> +&mpss_mem {
>> +	reg = <0x0 0x8b800000 0x0 0xf600000>;
> You're defining it here and overwriting it with an identical
> value.
>
> Looks like CrOS folks don't boot up the modem on non-LTE SKUs.
> Weird. Normally it would host some more software..
>
>> +};
>> +
>> +&remoteproc_mpss {
>> +	memory-region = <&mpss_mem>;
> This is identical to the entry in sc7280.dtsi.

Will remove it.

>
>> +};
>> +
>> +&video_mem {
>> +	reg = <0x0 0x8a700000 0x0 0x500000>;
>> +};
>> +
>> +&wifi {
>> +	memory-region = <&wlan_fw_mem>;
> No CE region?

Yes, no CE region is required here.

>
>> +};
>> +
>> +&wlan_fw_mem {
>> +	reg = <0x0 0x80c00000 0x0 0xc00000>;
> This is identical to the entry in sc7280.dtsi.

Will remove it.

>
>
> The memory map generally looks quite different to both chrome
> and fairphone.. are you sure it's all correct?

Yes, it's correct, it's different than chrome and fairphone.

Thanks
Komal

>
> Konrad

