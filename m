Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B39757B6877
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 14:05:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231934AbjJCMFm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 08:05:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231917AbjJCMFi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 08:05:38 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA227B3;
        Tue,  3 Oct 2023 05:05:32 -0700 (PDT)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 393AeBCq021511;
        Tue, 3 Oct 2023 12:05:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=Mf5hkpNVLRrJ0DbeBThf8Endug2Yp5jqAmqOujaXElo=;
 b=gYcSS5k62ytcVizAtwvw6K5RRgE44mqwcmPfKyHUuEsN+MZnYXE1EXPRI0Gc+cIEyq2h
 U+ADC2G8wHHqsutYFH35yB9SkbUaf/zZE6ibwZ0XZEPd13lKU6hTvWTVwFd/p5GE7QoQ
 xtpo3IPJjFcFyg93ghErOcXQ7NzP8spIkjxAig5K0NmsvFGYlc6bYThjVvBGtR59CKZ8
 f+BAfItciUxR9dRv85kt0b+czYqH5VXNny4v9wiqjMoyE3Ri81flPq8NLymZ29DAo44b
 XbeVjF83a3wE9jrwgx+9yq0y4BFXk1gFZtzKvvvEQzijLUCln7XK0psPunOxq5i+5SeI 4Q== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3tgbjgrvhc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 03 Oct 2023 12:05:19 +0000
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 393C5ILV003865
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 3 Oct 2023 12:05:18 GMT
Received: from [10.214.67.128] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.36; Tue, 3 Oct
 2023 05:05:14 -0700
Message-ID: <5899d23e-2f15-27c9-6cc1-82f7a3072feb@quicinc.com>
Date:   Tue, 3 Oct 2023 17:35:11 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH v2 2/2] arm64: dts: qcom: qcm6490: Add qcm6490 dts file
Content-Language: en-US
To:     Bryan O'Donoghue <bryan.odonoghue@linaro.org>, <agross@kernel.org>,
        <andersson@kernel.org>, <konrad.dybcio@linaro.org>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <conor+dt@kernel.org>
CC:     <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <luca.weiss@fairphone.com>
References: <20231003055655.30994-1-quic_kbajaj@quicinc.com>
 <20231003055655.30994-3-quic_kbajaj@quicinc.com>
 <14afec80-3616-4ae1-a9a4-51f9b7c51a31@linaro.org>
From:   Komal Bajaj <quic_kbajaj@quicinc.com>
In-Reply-To: <14afec80-3616-4ae1-a9a4-51f9b7c51a31@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: SsGwxsRu-1FIQGTRJ3bIdhyKCttmfzFU
X-Proofpoint-GUID: SsGwxsRu-1FIQGTRJ3bIdhyKCttmfzFU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-03_08,2023-10-02_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015
 lowpriorityscore=0 spamscore=0 priorityscore=1501 adultscore=0
 suspectscore=0 bulkscore=0 impostorscore=0 mlxlogscore=999 phishscore=0
 malwarescore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2309180000 definitions=main-2310030087
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/3/2023 2:33 PM, Bryan O'Donoghue wrote:
> On 03/10/2023 06:56, Komal Bajaj wrote:
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
>>   arch/arm64/boot/dts/qcom/Makefile        |   1 +
>>   arch/arm64/boot/dts/qcom/qcm6490-idp.dts | 335 +++++++++++++++++++++++
>>   arch/arm64/boot/dts/qcom/qcm6490.dtsi    |  94 +++++++
>>   3 files changed, 430 insertions(+)
>>   create mode 100644 arch/arm64/boot/dts/qcom/qcm6490-idp.dts
>>   create mode 100644 arch/arm64/boot/dts/qcom/qcm6490.dtsi
>>
>> diff --git a/arch/arm64/boot/dts/qcom/Makefile 
>> b/arch/arm64/boot/dts/qcom/Makefile
>> index 73c3be0f8872..3a2d9dbaacce 100644
>> --- a/arch/arm64/boot/dts/qcom/Makefile
>> +++ b/arch/arm64/boot/dts/qcom/Makefile
>> @@ -82,6 +82,7 @@ dtb-$(CONFIG_ARCH_QCOM)    += 
>> msm8998-sony-xperia-yoshino-maple.dtb
>>   dtb-$(CONFIG_ARCH_QCOM)    += msm8998-sony-xperia-yoshino-poplar.dtb
>>   dtb-$(CONFIG_ARCH_QCOM)    += msm8998-xiaomi-sagit.dtb
>>   dtb-$(CONFIG_ARCH_QCOM)    += qcm6490-fairphone-fp5.dtb
>> +dtb-$(CONFIG_ARCH_QCOM)    += qcm6490-idp.dtb
>>   dtb-$(CONFIG_ARCH_QCOM)    += qcs404-evb-1000.dtb
>>   dtb-$(CONFIG_ARCH_QCOM)    += qcs404-evb-4000.dtb
>>   dtb-$(CONFIG_ARCH_QCOM)    += qdu1000-idp.dtb
>> diff --git a/arch/arm64/boot/dts/qcom/qcm6490-idp.dts 
>> b/arch/arm64/boot/dts/qcom/qcm6490-idp.dts
>> new file mode 100644
>> index 000000000000..ab9fa9197fe3
>> --- /dev/null
>> +++ b/arch/arm64/boot/dts/qcom/qcm6490-idp.dts
>> @@ -0,0 +1,335 @@
>> +// SPDX-License-Identifier: BSD-3-Clause
>> +/*
>> + * Copyright (c) 2023 Qualcomm Innovation Center, Inc. All rights 
>> reserved.
>> + */
>> +
>> +/dts-v1/;
>> +
>> +#include <dt-bindings/iio/qcom,spmi-adc7-pmk8350.h>
>> +#include <dt-bindings/regulator/qcom,rpmh-regulator.h>
>> +#include "qcm6490.dtsi"
> This include should go last

Got it.

>
>> +#include "pm7325.dtsi"
>> +#include "pm8350c.dtsi"
>> +#include "pmk8350.dtsi"
>> +
>> +/ {
>> +    model = "Qualcomm Technologies, Inc. QCM6490 IDP";
>> +    compatible = "qcom,qcm6490-idp", "qcom,qcm6490";
>> +
>> +    aliases {
>> +        serial0 = &uart5;
>> +    };
>> +
>> +    chosen {
>> +        stdout-path = "serial0:115200n8";
>> +    };
>> +};
>> +
>> +&apps_rsc {
>> +    regulators-0 {
>> +        compatible = "qcom,pm7325-rpmh-regulators";
>> +        qcom,pmic-id = "b";
>> +
>> +        vreg_s1b_1p8: smps1 {
>> +            regulator-min-microvolt = <1856000>;
>> +            regulator-max-microvolt = <2040000>;
>> +        };
>> +
>> +        vreg_s7b_0p9: smps7 {
>> +            regulator-min-microvolt = <535000>;
>> +            regulator-max-microvolt = <1120000>;
>> +        };
>> +
>> +        vreg_s8b_1p2: smps8 {
>> +            regulator-min-microvolt = <1256000>;
>> +            regulator-max-microvolt = <1500000>;
>> +            regulator-initial-mode = <RPMH_REGULATOR_MODE_RET>;
>> +        };
>> +
>> +        vreg_l1b_0p8: ldo1 {
>> +            regulator-min-microvolt = <825000>;
>> +            regulator-max-microvolt = <925000>;
>> +            regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
>> +        };
>> +
>> +        vreg_l2b_3p0: ldo2 {
>> +            regulator-min-microvolt = <2700000>;
>> +            regulator-max-microvolt = <3544000>;
>> +            regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
>> +        };
>> +
>> +        vreg_l6b_1p2: ldo6 {
>> +            regulator-min-microvolt = <1140000>;
>> +            regulator-max-microvolt = <1260000>;
>> +            regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
>> +        };
>> +
>> +        vreg_l7b_2p9: ldo7 {
>> +            regulator-min-microvolt = <2960000>;
>> +            regulator-max-microvolt = <2960000>;
>> +            regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
>> +        };
>> +
>> +        vreg_l8b_0p9: ldo8 {
>> +            regulator-min-microvolt = <870000>;
>> +            regulator-max-microvolt = <970000>;
>> +            regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
>> +        };
>> +
>> +        vreg_l9b_1p2: ldo9 {
>> +            regulator-min-microvolt = <1080000>;
>> +            regulator-max-microvolt = <1304000>;
>> +            regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
>> +        };
>> +
>> +        vreg_l11b_1p7: ldo11 {
>> +            regulator-min-microvolt = <1504000>;
>> +            regulator-max-microvolt = <2000000>;
>> +            regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
>> +        };
>> +
>> +        vreg_l12b_0p8: ldo12 {
>> +            regulator-min-microvolt = <751000>;
>> +            regulator-max-microvolt = <824000>;
>> +            regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
>> +        };
>> +
>> +        vreg_l13b_0p8: ldo13 {
>> +            regulator-min-microvolt = <530000>;
>> +            regulator-max-microvolt = <824000>;
>> +            regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
>> +        };
>> +
>> +        vreg_l14b_1p2: ldo14 {
>> +            regulator-min-microvolt = <1080000>;
>> +            regulator-max-microvolt = <1304000>;
>> +            regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
>> +        };
>> +
>> +        vreg_l15b_0p8: ldo15 {
>> +            regulator-min-microvolt = <765000>;
>> +            regulator-max-microvolt = <1020000>;
>> +            regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
>> +        };
>> +
>> +        vreg_l16b_1p2: ldo16 {
>> +            regulator-min-microvolt = <1100000>;
>> +            regulator-max-microvolt = <1300000>;
>> +            regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
>> +        };
>> +
>> +        vreg_l17b_1p8: ldo17 {
>> +            regulator-min-microvolt = <1700000>;
>> +            regulator-max-microvolt = <1900000>;
>> +            regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
>> +        };
>> +
>> +        vreg_l18b_1p8: ldo18 {
>> +            regulator-min-microvolt = <1800000>;
>> +            regulator-max-microvolt = <2000000>;
>> +            regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
>> +        };
>> +
>> +        vreg_l19b_1p8: ldo19 {
>> +            regulator-min-microvolt = <1800000>;
>> +            regulator-max-microvolt = <1800000>;
>> +            regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
>> +        };
>> +    };
>> +
>> +    regulators-1 {
>> +        compatible = "qcom,pm8350c-rpmh-regulators";
>> +        qcom,pmic-id = "c";
>> +
>> +        vreg_s1c_2p2: smps1 {
>> +            regulator-min-microvolt = <2190000>;
>> +            regulator-max-microvolt = <2210000>;
>> +            regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
>> +        };
>> +
>> +        vreg_s9c_1p0: smps9 {
>> +            regulator-min-microvolt = <1010000>;
>> +            regulator-max-microvolt = <1170000>;
>> +            regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
>> +        };
>> +
>> +        vreg_l1c_1p8: ldo1 {
>> +            regulator-min-microvolt = <1800000>;
>> +            regulator-max-microvolt = <1980000>;
>> +            regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
>> +        };
>> +
>> +        vreg_l2c_1p8: ldo2 {
>> +            regulator-min-microvolt = <1620000>;
>> +            regulator-max-microvolt = <1980000>;
>> +            regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
>> +        };
>> +
>> +        vreg_l3c_3p0: ldo3 {
>> +            regulator-min-microvolt = <2800000>;
>> +            regulator-max-microvolt = <3540000>;
>> +            regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
>> +        };
>> +
>> +        vreg_l4c_1p8: ldo4 {
>> +            regulator-min-microvolt = <1620000>;
>> +            regulator-max-microvolt = <3300000>;
>> +            regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
>> +        };
>> +
>> +        vreg_l5c_1p8: ldo5 {
>> +            regulator-min-microvolt = <1620000>;
>> +            regulator-max-microvolt = <3300000>;
>> +            regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
>> +        };
>> +
>> +        vreg_l6c_2p9: ldo6 {
>> +            regulator-min-microvolt = <1800000>;
>> +            regulator-max-microvolt = <2950000>;
>> +            regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
>> +        };
>> +
>> +        vreg_l7c_3p0: ldo7 {
>> +            regulator-min-microvolt = <3000000>;
>> +            regulator-max-microvolt = <3544000>;
>> +            regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
>> +        };
>> +
>> +        vreg_l8c_1p8: ldo8 {
>> +            regulator-min-microvolt = <1620000>;
>> +            regulator-max-microvolt = <2000000>;
>> +            regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
>> +        };
>> +
>> +        vreg_l9c_2p9: ldo9 {
>> +            regulator-min-microvolt = <2960000>;
>> +            regulator-max-microvolt = <2960000>;
>> +            regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
>> +        };
>> +
>> +        vreg_l10c_0p8: ldo10 {
>> +            regulator-min-microvolt = <720000>;
>> +            regulator-max-microvolt = <1050000>;
>> +            regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
>> +        };
>> +
>> +        vreg_l11c_2p8: ldo11 {
>> +            regulator-min-microvolt = <2800000>;
>> +            regulator-max-microvolt = <3544000>;
>> +            regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
>> +        };
>> +
>> +        vreg_l12c_1p8: ldo12 {
>> +            regulator-min-microvolt = <1650000>;
>> +            regulator-max-microvolt = <2000000>;
>> +            regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
>> +        };
>> +
>> +        vreg_l13c_3p0: ldo13 {
>> +            regulator-min-microvolt = <2700000>;
>> +            regulator-max-microvolt = <3544000>;
>> +            regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
>> +        };
>> +
>> +        vreg_bob: bob {
>> +            regulator-min-microvolt = <3008000>;
>> +            regulator-max-microvolt = <3960000>;
>> +        };
>> +    };
>> +};
>> +
>> +&gpi_dma0 {
>> +    status = "okay";
>> +};
>> +
>> +&gpi_dma1 {
>> +    status = "okay";
>> +};
>> +
>> +&qupv3_id_0 {
>> +    status = "okay";
>> +};
>> +
>> +&qupv3_id_1 {
>> +    status = "okay";
>> +};
>> +
>> +&sdhc_1 {
>> +    non-removable;
>> +    no-sd;
>> +    no-sdio;
>> +
>> +    vmmc-supply = <&vreg_l7b_2p9>;
>> +    vqmmc-supply = <&vreg_l19b_1p8>;
>> +
>> +    status = "okay";
>> +};
>> +
>> +&uart5 {
>> +    compatible = "qcom,geni-debug-uart";
>> +    status = "okay";
>> +};
>> +
>> +&usb_1 {
>> +    status = "okay";
>> +};
>> +
>> +&usb_1_dwc3 {
>> +    dr_mode = "peripheral";
>> +};
>> +
>> +&usb_1_hsphy {
>> +    vdda-pll-supply = <&vreg_l10c_0p8>;
>> +    vdda33-supply = <&vreg_l2b_3p0>;
>> +    vdda18-supply = <&vreg_l1c_1p8>;
>> +    qcom,hs-rise-fall-time-bp = <0>;
>> +    qcom,squelch-detector-bp = <(-2090)>;
>> +    qcom,hs-disconnect-bp = <1743>;
>> +    qcom,hs-amplitude-bp = <1780>;
>> +    qcom,hs-crossover-voltage-microvolt = <(-31000)>;
>> +    qcom,hs-output-impedance-micro-ohms = <2600000>;
>> +
>> +    status = "okay";
>> +};
>> +
>> +&usb_1_qmpphy {
>> +    vdda-phy-supply = <&vreg_l6b_1p2>;
>> +    vdda-pll-supply = <&vreg_l1b_0p8>;
>> +
>> +    status = "okay";
>> +};
>> +
>> +/* PINCTRL - additions to nodes defined in sc7280.dtsi */
>> +
>> +&pm8350c_pwm {
>> +    status = "okay";
>> +};
>> +
>> +&qup_uart5_tx {
>> +    drive-strength = <2>;
>> +    bias-disable;
>> +};
>> +
>> +&qup_uart5_rx {
>> +    drive-strength = <2>;
>> +    bias-pull-up;
>> +};
>> +
>> +&sdc1_clk {
>> +    bias-disable;
>> +    drive-strength = <16>;
>> +};
>> +
>> +&sdc1_cmd {
>> +    bias-pull-up;
>> +    drive-strength = <10>;
>> +};
>> +
>> +&sdc1_data {
>> +    bias-pull-up;
>> +    drive-strength = <10>;
>> +};
>> +
>> +&sdc1_rclk {
>> +    bias-pull-down;
>> +};
>
> These nodes are out-of-order too, you should sort these in 
> alphanumerically. q before r before s etc.

Got it. Will sort these nodes.

Thanks
Komal

>
>> diff --git a/arch/arm64/boot/dts/qcom/qcm6490.dtsi 
>> b/arch/arm64/boot/dts/qcom/qcm6490.dtsi
>> new file mode 100644
>> index 000000000000..b93270cae9ae
>> --- /dev/null
>> +++ b/arch/arm64/boot/dts/qcom/qcm6490.dtsi
>> @@ -0,0 +1,94 @@
>> +// SPDX-License-Identifier: BSD-3-Clause
>> +/*
>> + * Copyright (c) 2023 Qualcomm Innovation Center, Inc. All rights 
>> reserved.
>> + */
>> +
>> +#include "sc7280.dtsi"
>> +
>> +/*
>> + * Delete unused sc7280 memory nodes and define the memory regions
>> + * required by qcm6490
>> + */
>> +/delete-node/ &rmtfs_mem;
>> +/delete-node/ &wlan_ce_mem;
>> +
>> +/{
>> +    reserved-memory {
>> +        cdsp_secure_heap_mem: cdsp-secure-heap@81800000 {
>> +            reg = <0x0 0x81800000 0x0 0x1e00000>;
>> +            no-map;
>> +        };
>> +
>> +        camera_mem: camera@84300000 {
>> +            reg = <0x0 0x84300000 0x0 0x500000>;
>> +            no-map;
>> +        };
>> +
>> +        wpss_mem: wpss@0x84800000 {
>> +            reg = <0x0 0x84800000 0x0 0x1900000>;
>> +            no-map;
>> +        };
>> +
>> +        adsp_mem: adsp@86100000 {
>> +            reg = <0x0 0x86100000 0x0 0x2800000>;
>> +            no-map;
>> +        };
>> +
>> +        cdsp_mem: cdsp@88900000 {
>> +            reg = <0x0 0x88900000 0x0 0x1e00000>;
>> +            no-map;
>> +        };
>> +
>> +        cvp_mem: cvp@8ac00000 {
>> +            reg = <0x0 0x8ac00000 0x0 0x500000>;
>> +            no-map;
>> +        };
>> +
>> +        ipa_gsi_mem: ipa-gsi@8b110000 {
>> +            reg = <0x0 0x8b110000 0x0 0xa000>;
>> +            no-map;
>> +        };
>> +
>> +        gpu_microcode_mem: gpu-microcode@8b11a000 {
>> +            reg = <0x0 0x8b11a000 0x0 0x2000>;
>> +            no-map;
>> +        };
>> +
>> +        mpss_mem: mpss@8b800000 {
>> +            reg = <0x0 0x8b800000 0x0 0xf600000>;
>> +            no-map;
>> +        };
>> +
>> +        tz_stat_mem: tz-stat@c0000000 {
>> +            reg = <0x0 0xc0000000 0x0 0x100000>;
>> +            no-map;
>> +        };
>> +
>> +        tags_mem: tags@c0100000 {
>> +            reg = <0x0 0xc0100000 0x0 0x1200000>;
>> +            no-map;
>> +        };
>> +
>> +        qtee_mem: qtee@c1300000 {
>> +            reg = <0x0 0xc1300000 0x0 0x500000>;
>> +            no-map;
>> +        };
>> +
>> +        trusted_apps_mem: trusted_apps@c1800000 {
>> +            reg = <0x0 0xc1800000 0x0 0x3900000>;
>> +            no-map;
>> +        };
>> +    };
>> +};
>> +
>> +&video_mem {
>> +    reg = <0x0 0x8a700000 0x0 0x500000>;
>> +};
>> +
>> +&wifi {
>> +    memory-region = <&wlan_fw_mem>;
>> +};
>> +
>> +&xbl_mem {
>> +    reg = <0x0 0x80700000 0x0 0x100000>;
>> +};
>> -- 
>> 2.42.0
>>
>

