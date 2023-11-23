Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 983F37F6148
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 15:18:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345754AbjKWOSg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Nov 2023 09:18:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345750AbjKWOS0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Nov 2023 09:18:26 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DFB5D71;
        Thu, 23 Nov 2023 06:18:32 -0800 (PST)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3ANE6dnO003764;
        Thu, 23 Nov 2023 14:18:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=SlZWWuR7wKXuEEcytG0ZsycisoJUTkZcgDwDzblxsCA=;
 b=Dcr54c2gV4JP/d60ltBZUIPgvP9+5celUlm4W3q7ItmfL7LvPv3n9jtcX0AfmD1t3WAT
 wMOcLDjhLYc/nP9yR7Yyz3o+w7UsehEjcx9K2fZRrfzuKDRrbruLsKs+VFBVOf/x4hBM
 Z/vvIzW5rXA7g47Zc3VLhKJpV7R+A+L+7CZbd2Z/IjAQeixIslN13eAlOdg33NzfbGaR
 mKNe25nfkgGBzeRjbSwbQcvWFFVqpdk79xvwY0Y5jsBfbHUDQDQrSxViji+vgns/sVlr
 vB6QoqxDcpLqjMt8Z+V6xZzEV9bXip3GQN15VhOA1/KleypZMkiKi+kS2naYyEY8GHLi Bw== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3uhgudb4cb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 23 Nov 2023 14:18:26 +0000
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3ANEIPxH009099
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 23 Nov 2023 14:18:25 GMT
Received: from [10.214.67.128] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Thu, 23 Nov
 2023 06:18:21 -0800
Message-ID: <c63f3845-e9fd-9171-5d3b-d28b51db2c23@quicinc.com>
Date:   Thu, 23 Nov 2023 19:48:18 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH v5 3/3] arm64: dts: qcom: Add base qcs6490-rb3gen2 board
 dts
Content-Language: en-US
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
CC:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Naina Mehta <quic_nainmeht@quicinc.com>
References: <20231120134754.9526-1-quic_kbajaj@quicinc.com>
 <20231120134754.9526-4-quic_kbajaj@quicinc.com>
 <CAA8EJpoR_C2PC7Juo2oXijuPrWgVXqeVffKwpWLqJD4a1Ay-NQ@mail.gmail.com>
From:   Komal Bajaj <quic_kbajaj@quicinc.com>
In-Reply-To: <CAA8EJpoR_C2PC7Juo2oXijuPrWgVXqeVffKwpWLqJD4a1Ay-NQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: PYh36uqT8WFvQcAfanuISVItJLFakRzR
X-Proofpoint-ORIG-GUID: PYh36uqT8WFvQcAfanuISVItJLFakRzR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-23_12,2023-11-22_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 spamscore=0 mlxlogscore=999 impostorscore=0 malwarescore=0
 priorityscore=1501 clxscore=1015 mlxscore=0 adultscore=0 bulkscore=0
 suspectscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2311060000 definitions=main-2311230103
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/20/2023 8:28 PM, Dmitry Baryshkov wrote:
> On Mon, 20 Nov 2023 at 15:48, Komal Bajaj <quic_kbajaj@quicinc.com> wrote:
>> Add DTS for Qualcomm qcs6490-rb3gen2 board which uses
>> QCS6490 SoC. This adds debug uart and usb support along
>> with regulators found on this board.
>>
>> Co-developed-by: Naina Mehta <quic_nainmeht@quicinc.com>
>> Signed-off-by: Naina Mehta <quic_nainmeht@quicinc.com>
>> Signed-off-by: Komal Bajaj <quic_kbajaj@quicinc.com>
>> Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
>> ---
>>   arch/arm64/boot/dts/qcom/Makefile            |   1 +
>>   arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts | 410 +++++++++++++++++++
>>   2 files changed, 411 insertions(+)
>>   create mode 100644 arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts
>>
>> diff --git a/arch/arm64/boot/dts/qcom/Makefile b/arch/arm64/boot/dts/qcom/Makefile
>> index 77babebe4904..4c0f9e4a2e5b 100644
>> --- a/arch/arm64/boot/dts/qcom/Makefile
>> +++ b/arch/arm64/boot/dts/qcom/Makefile
>> @@ -90,6 +90,7 @@ dtb-$(CONFIG_ARCH_QCOM)       += qcm6490-fairphone-fp5.dtb
>>   dtb-$(CONFIG_ARCH_QCOM)        += qcm6490-idp.dtb
>>   dtb-$(CONFIG_ARCH_QCOM)        += qcs404-evb-1000.dtb
>>   dtb-$(CONFIG_ARCH_QCOM)        += qcs404-evb-4000.dtb
>> +dtb-$(CONFIG_ARCH_QCOM)        += qcs6490-rb3gen2.dtb
>>   dtb-$(CONFIG_ARCH_QCOM)        += qdu1000-idp.dtb
>>   dtb-$(CONFIG_ARCH_QCOM)        += qrb2210-rb1.dtb
>>   dtb-$(CONFIG_ARCH_QCOM)        += qrb4210-rb2.dtb
>> diff --git a/arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts b/arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts
>> new file mode 100644
>> index 000000000000..f023dcf768f1
>> --- /dev/null
>> +++ b/arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts
>> @@ -0,0 +1,410 @@
>> +// SPDX-License-Identifier: BSD-3-Clause
>> +/*
>> + * Copyright (c) 2023 Qualcomm Innovation Center, Inc. All rights reserved.
>> + */
>> +
>> +/dts-v1/;
>> +
>> +/* PM7250B is configured to use SID8/9 */
>> +#define PM7250B_SID 8
>> +#define PM7250B_SID1 9
>> +
>> +#include <dt-bindings/regulator/qcom,rpmh-regulator.h>
>> +#include "sc7280.dtsi"
>> +#include "pm7250b.dtsi"
>> +#include "pm7325.dtsi"
>> +#include "pm8350c.dtsi"
>> +#include "pmk8350.dtsi"
>> +
>> +/delete-node/ &ipa_fw_mem;
>> +/delete-node/ &remoteproc_mpss;
>> +/delete-node/ &rmtfs_mem;
>> +/delete-node/ &video_mem;
>> +/delete-node/ &wlan_ce_mem;
>> +/delete-node/ &xbl_mem;
>> +
>> +/ {
>> +       model = "Qualcomm Technologies, Inc. Robotics RB3gen2";
>> +       compatible = "qcom,qcs6490-rb3gen2", "qcom,qcm6490";
>> +       chassis-type = "embedded";
>> +
>> +       aliases {
>> +               serial0 = &uart5;
>> +       };
>> +
>> +       chosen {
>> +               stdout-path = "serial0:115200n8";
>> +       };
> The board definitely has some fixed-voltage regulators. At least the
> vph-pwr. Please describe them here.

Yes, Will add it here.

>
>> +
>> +       reserved-memory {
>> +               xbl_mem: xbl@80700000 {
>> +                       reg = <0x0 0x80700000 0x0 0x100000>;
>> +                       no-map;
>> +               };
>> +
>> +               cdsp_secure_heap_mem: cdsp-secure-heap@81800000 {
>> +                       reg = <0x0 0x81800000 0x0 0x1e00000>;
>> +                       no-map;
>> +               };
>> +
>> +               camera_mem: camera@84300000 {
>> +                       reg = <0x0 0x84300000 0x0 0x500000>;
>> +                       no-map;
>> +               };
>> +
>> +               wpss_mem: wpss@84800000 {
>> +                       reg = <0x0 0x84800000 0x0 0x1900000>;
>> +                       no-map;
>> +               };
>> +
>> +               adsp_mem: adsp@86100000 {
>> +                       reg = <0x0 0x86100000 0x0 0x2800000>;
>> +                       no-map;
>> +               };
>> +
>> +               cdsp_mem: cdsp@88900000 {
>> +                       reg = <0x0 0x88900000 0x0 0x1e00000>;
>> +                       no-map;
>> +               };
>> +
>> +               video_mem: video@8a700000 {
>> +                       reg = <0x0 0x8a700000 0x0 0x700000>;
>> +                       no-map;
>> +               };
>> +
>> +               cvp_mem: cvp@8ae00000 {
>> +                       reg = <0x0 0x8ae00000 0x0 0x500000>;
>> +                       no-map;
>> +               };
>> +
>> +               ipa_fw_mem: ipa-fw@8b300000 {
>> +                       reg = <0x0 0x8b300000 0x0 0x10000>;
>> +                       no-map;
>> +               };
>> +
>> +               ipa_gsi_mem: ipa-gsi@8b310000 {
>> +                       reg = <0x0 0x8b310000 0x0 0xa000>;
>> +                       no-map;
>> +               };
>> +
>> +               gpu_microcode_mem: gpu-microcode@8b31a000 {
>> +                       reg = <0x0 0x8b31a000 0x0 0x2000>;
>> +                       no-map;
>> +               };
>> +
>> +               tz_stat_mem: tz-stat@c0000000 {
>> +                       reg = <0x0 0xc0000000 0x0 0x100000>;
>> +                       no-map;
>> +               };
>> +
>> +               tags_mem: tags@c0100000 {
>> +                       reg = <0x0 0xc0100000 0x0 0x1200000>;
>> +                       no-map;
>> +               };
>> +
>> +               qtee_mem: qtee@c1300000 {
>> +                       reg = <0x0 0xc1300000 0x0 0x500000>;
>> +                       no-map;
>> +               };
>> +
>> +               trusted_apps_mem: trusted_apps@c1800000 {
>> +                       reg = <0x0 0xc1800000 0x0 0x1c00000>;
>> +                       no-map;
>> +               };
>> +
>> +               debug_vm_mem: debug-vm@d0600000 {
>> +                       reg = <0x0 0xd0600000 0x0 0x100000>;
>> +                       no-map;
>> +               };
>> +       };
>> +};
>> +
>> +&apps_rsc {
>> +       regulators-0 {
>> +               compatible = "qcom,pm7325-rpmh-regulators";
>> +               qcom,pmic-id = "b";
> No supplies for any of the regulators? That's a pity.

Sorry for this, will update it.

>
>> +
>> +               vreg_s1b_1p872: smps1 {
>> +                       regulator-min-microvolt = <1840000>;
>> +                       regulator-max-microvolt = <2040000>;
>> +               };
>> +
>> +               vreg_s2b_0p876: smps2 {
>> +                       regulator-min-microvolt = <570070>;
>> +                       regulator-max-microvolt = <1050000>;
>> +               };
>> +
>> +               vreg_s7b_0p972: smps7 {
>> +                       regulator-min-microvolt = <535000>;
>> +                       regulator-max-microvolt = <1120000>;
>> +               };
>> +
>> +               vreg_s8b_1p272: smps8 {
>> +                       regulator-min-microvolt = <1200000>;
>> +                       regulator-max-microvolt = <1500000>;
>> +                       regulator-initial-mode = <RPMH_REGULATOR_MODE_RET>;
>> +               };
>> +
>> +               vreg_l1b_0p912: ldo1 {
>> +                       regulator-min-microvolt = <825000>;
>> +                       regulator-max-microvolt = <925000>;
>> +                       regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
>> +               };
>> +
>> +               vreg_l2b_3p072: ldo2 {
>> +                       regulator-min-microvolt = <2700000>;
>> +                       regulator-max-microvolt = <3544000>;
>> +                       regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
>> +               };
>> +
>> +               vreg_l3b_0p504: ldo3 {
>> +                       regulator-min-microvolt = <312000>;
>> +                       regulator-max-microvolt = <910000>;
>> +                       regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
>> +               };
>> +
>> +               vreg_l4b_0p752: ldo4 {
>> +                       regulator-min-microvolt = <752000>;
>> +                       regulator-max-microvolt = <820000>;
>> +                       regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
>> +               };
>> +
>> +               reg_l5b_0p752: ldo5 {
>> +                       regulator-min-microvolt = <552000>;
>> +                       regulator-max-microvolt = <832000>;
>> +                       regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
>> +               };
>> +
>> +               vreg_l6b_1p2: ldo6 {
>> +                       regulator-min-microvolt = <1140000>;
>> +                       regulator-max-microvolt = <1260000>;
>> +                       regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
>> +               };
>> +
>> +               vreg_l7b_2p952: ldo7 {
> Voltage ranges must be added here.

Yes. It was a mistake will add them.

>
>> +                       regulator-allow-set-load;
>> +                       regulator-allowed-modes = <RPMH_REGULATOR_MODE_LPM RPMH_REGULATOR_MODE_HPM>;
>> +                       regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
>> +               };
>> +
>> +               vreg_l8b_0p904: ldo8 {
>> +                       regulator-min-microvolt = <870000>;
>> +                       regulator-max-microvolt = <970000>;
>> +                       regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
>> +               };
>> +
>> +               vreg_l9b_1p2: ldo9 {
> Voltage ranges must be added here.

ACK

Thanks,
Komal

>
>> +                       regulator-allow-set-load;
>> +                       regulator-allowed-modes = <RPMH_REGULATOR_MODE_LPM RPMH_REGULATOR_MODE_HPM>;
>> +                       regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
>> +               };
>> +
>> +               vreg_l11b_1p504: ldo11 {
>> +                       regulator-min-microvolt = <1504000>;
>> +                       regulator-max-microvolt = <2000000>;
>> +                       regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
>> +               };
>> +
>> +               vreg_l12b_0p751: ldo12 {
>> +                       regulator-min-microvolt = <751000>;
>> +                       regulator-max-microvolt = <824000>;
>> +                       regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
>> +               };
>> +
>> +               vreg_l13b_0p53: ldo13 {
>> +                       regulator-min-microvolt = <530000>;
>> +                       regulator-max-microvolt = <824000>;
>> +                       regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
>> +               };
>> +
>> +               vreg_l14b_1p08: ldo14 {
>> +                       regulator-min-microvolt = <1080000>;
>> +                       regulator-max-microvolt = <1304000>;
>> +                       regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
>> +               };
>> +
>> +               vreg_l15b_0p765: ldo15 {
>> +                       regulator-min-microvolt = <765000>;
>> +                       regulator-max-microvolt = <1020000>;
>> +                       regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
>> +               };
>> +
>> +               vreg_l16b_1p1: ldo16 {
>> +                       regulator-min-microvolt = <1100000>;
>> +                       regulator-max-microvolt = <1300000>;
>> +                       regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
>> +               };
>> +
>> +               vreg_l17b_1p7: ldo17 {
>> +                       regulator-min-microvolt = <1700000>;
>> +                       regulator-max-microvolt = <1900000>;
>> +                       regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
>> +               };
>> +
>> +               vreg_l18b_1p8: ldo18 {
>> +                       regulator-min-microvolt = <1800000>;
>> +                       regulator-max-microvolt = <2000000>;
>> +                       regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
>> +               };
>> +
>> +               vreg_l19b_1p8: ldo19 {
>> +                       regulator-min-microvolt = <1800000>;
>> +                       regulator-max-microvolt = <2000000>;
>> +                       regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
>> +               };
>> +       };
>> +
>> +       regulators-1 {
>> +               compatible = "qcom,pm8350c-rpmh-regulators";
>> +               qcom,pmic-id = "c";
>> +
>> +               vreg_s1c_2p19: smps1 {
>> +                       regulator-min-microvolt = <2190000>;
>> +                       regulator-max-microvolt = <2210000>;
>> +               };
>> +
>> +               vreg_s2c_0p752: smps2 {
>> +                       regulator-min-microvolt = <750000>;
>> +                       regulator-max-microvolt = <800000>;
>> +               };
>> +
>> +               vreg_s5c_0p752: smps5 {
>> +                       regulator-min-microvolt = <465000>;
>> +                       regulator-max-microvolt = <1050000>;
>> +               };
>> +
>> +               vreg_s7c_0p752: smps7 {
>> +                       regulator-min-microvolt = <465000>;
>> +                       regulator-max-microvolt = <800000>;
>> +               };
>> +
>> +               vreg_s9c_1p084: smps9 {
>> +                       regulator-min-microvolt = <1010000>;
>> +                       regulator-max-microvolt = <1170000>;
>> +               };
>> +
>> +               vreg_l1c_1p8: ldo1 {
>> +                       regulator-min-microvolt = <1800000>;
>> +                       regulator-max-microvolt = <1980000>;
>> +                       regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
>> +               };
>> +
>> +               vreg_l2c_1p62: ldo2 {
>> +                       regulator-min-microvolt = <1620000>;
>> +                       regulator-max-microvolt = <1980000>;
>> +                       regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
>> +               };
>> +
>> +               vreg_l3c_2p8: ldo3 {
>> +                       regulator-min-microvolt = <2800000>;
>> +                       regulator-max-microvolt = <3540000>;
>> +                       regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
>> +               };
>> +
>> +               vreg_l4c_1p62: ldo4 {
>> +                       regulator-min-microvolt = <1620000>;
>> +                       regulator-max-microvolt = <3300000>;
>> +                       regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
>> +               };
>> +
>> +               vreg_l5c_1p62: ldo5 {
>> +                       regulator-min-microvolt = <1620000>;
>> +                       regulator-max-microvolt = <3300000>;
>> +                       regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
>> +               };
>> +
>> +               vreg_l6c_2p96: ldo6 {
>> +                       regulator-min-microvolt = <1650000>;
>> +                       regulator-max-microvolt = <3544000>;
>> +                       regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
>> +               };
>> +
>> +               vreg_l7c_3p0: ldo7 {
>> +                       regulator-min-microvolt = <3000000>;
>> +                       regulator-max-microvolt = <3544000>;
>> +                       regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
>> +               };
>> +
>> +               vreg_l8c_1p62: ldo8 {
>> +                       regulator-min-microvolt = <1620000>;
>> +                       regulator-max-microvolt = <2000000>;
>> +                       regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
>> +               };
>> +
>> +               vreg_l9c_2p96: ldo9 {
>> +                       regulator-min-microvolt = <2700000>;
>> +                       regulator-max-microvolt = <35440000>;
>> +                       regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
>> +               };
>> +
>> +               vreg_l10c_0p88: ldo10 {
>> +                       regulator-min-microvolt = <720000>;
>> +                       regulator-max-microvolt = <1050000>;
>> +                       regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
>> +               };
>> +
>> +               vreg_l11c_2p8: ldo11 {
>> +                       regulator-min-microvolt = <2800000>;
>> +                       regulator-max-microvolt = <3544000>;
>> +                       regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
>> +               };
>> +
>> +               vreg_l12c_1p65: ldo12 {
>> +                       regulator-min-microvolt = <1650000>;
>> +                       regulator-max-microvolt = <2000000>;
>> +                       regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
>> +               };
>> +
>> +               vreg_l13c_2p7: ldo13 {
>> +                       regulator-min-microvolt = <2700000>;
>> +                       regulator-max-microvolt = <3544000>;
>> +                       regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
>> +               };
>> +
>> +               vreg_bob_3p296: bob {
>> +                       regulator-min-microvolt = <3008000>;
>> +                       regulator-max-microvolt = <3960000>;
>> +               };
>> +       };
>> +};
>> +
>> +&qupv3_id_0 {
>> +       status = "okay";
>> +};
>> +
>> +&tlmm {
>> +       gpio-reserved-ranges = <32 2>, /* ADSP */
>> +                              <48 4>; /* NFC */
>> +};
>> +
>> +&uart5 {
>> +       compatible = "qcom,geni-debug-uart";
>> +       status = "okay";
>> +};
>> +
>> +&usb_1 {
>> +       status = "okay";
>> +};
>> +
>> +&usb_1_dwc3 {
>> +       dr_mode = "peripheral";
>> +};
>> +
>> +&usb_1_hsphy {
>> +       vdda-pll-supply = <&vreg_l10c_0p88>;
>> +       vdda33-supply = <&vreg_l2b_3p072>;
>> +       vdda18-supply = <&vreg_l1c_1p8>;
>> +
>> +       status = "okay";
>> +};
>> +
>> +&usb_1_qmpphy {
>> +       vdda-phy-supply = <&vreg_l6b_1p2>;
>> +       vdda-pll-supply = <&vreg_l1b_0p912>;
>> +
>> +       status = "okay";
>> +};
>> +
>> +&wifi {
>> +       memory-region = <&wlan_fw_mem>;
> Same question regarding the CE region.
>
>> +};
>> --
>> 2.42.0
>>
>>
>

