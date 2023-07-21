Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A31A75CCA5
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 17:52:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229785AbjGUPwP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jul 2023 11:52:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232307AbjGUPvy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jul 2023 11:51:54 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D83E4204;
        Fri, 21 Jul 2023 08:51:30 -0700 (PDT)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36LEUFWS027381;
        Fri, 21 Jul 2023 15:50:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=wgnGZHbIoJ+Tel2Emd5h8/25wCwNLdaLGk5yznKHd3w=;
 b=NzBwJRVanLMvvClAzMWoLAf6bfOTURdpO1caceiPvWqyt/q20wHf64fWcqvJTM5Zlx62
 6BBmcZj5gpRLaE1IdIVFKzt/Tm/1sno4qzxUXNewl2x17Og0vs+VoiI2NdeTEgznDKMr
 ueWHGxt7qLuL4jzg60A/+bc1o6tU4Cu4U5e0QphDXGDiXFFtyr1/caPYYzXX+bdptoeO
 BGCfVfRzLyA8Uzq7X32+knCOV9BEutpaeUlQRj+W1AT855ij4zcGmJ3AEK+vIk37gpb+
 pt+j4/Dc7KQt0FqOH10anRT8HI/1nKrrQuetCfNiseYJdObkVLIK0ytUnvpqWgaLtYa+ LQ== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3ryksesawg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 21 Jul 2023 15:50:41 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 36LFoemt002019
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 21 Jul 2023 15:50:40 GMT
Received: from [10.226.59.182] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.30; Fri, 21 Jul
 2023 08:50:39 -0700
Message-ID: <43afe706-5765-a8e7-2bbe-d9b21ec7a06e@quicinc.com>
Date:   Fri, 21 Jul 2023 09:50:32 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.0
Subject: Re: [PATCH 09/11] arm64: dts: qcom: msm8998: Remove AGGRE2 clock from
 SLPI
Content-Language: en-US
To:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        "Krzysztof Kozlowski" <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Sibi Sankar <quic_sibis@quicinc.com>
CC:     Marijn Suijten <marijn.suijten@somainline.org>,
        <linux-arm-msm@vger.kernel.org>,
        <linux-remoteproc@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20230721-topic-rpm_clk_cleanup-v1-0-cf6cd5c621d5@linaro.org>
 <20230721-topic-rpm_clk_cleanup-v1-9-cf6cd5c621d5@linaro.org>
From:   Jeffrey Hugo <quic_jhugo@quicinc.com>
In-Reply-To: <20230721-topic-rpm_clk_cleanup-v1-9-cf6cd5c621d5@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: eSgD9s2AiCToG3pVyk6vRnuqxeuYDYTR
X-Proofpoint-ORIG-GUID: eSgD9s2AiCToG3pVyk6vRnuqxeuYDYTR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-21_10,2023-07-20_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 impostorscore=0
 lowpriorityscore=0 suspectscore=0 malwarescore=0 phishscore=0
 mlxlogscore=947 mlxscore=0 spamscore=0 adultscore=0 bulkscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2307210141
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/21/2023 9:36 AM, Konrad Dybcio wrote:
> The AGGRE2 clock is a clock for the entire AGGRE2 bus, managed from
> within the interconnect driver. Attaching it to SLPI was a total hack.
> Get rid of it.

Nit - why do we care what driver manages the clock?  DT describes 
hardware...

The entire SLPI block hangs off the AGGRE2 bus, so that bus needs to be 
on for the SLPI.  I agree that AGGRE2 is really an interconnect device 
and SLPI should be a consumer of that, but we don't have 8998 
interconnects defined yet.  Seems like this hack is still needed.

> 
> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> ---
>   arch/arm64/boot/dts/qcom/msm8998.dtsi | 5 ++---
>   1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/msm8998.dtsi b/arch/arm64/boot/dts/qcom/msm8998.dtsi
> index 360fe3edcc08..547c3f9654a6 100644
> --- a/arch/arm64/boot/dts/qcom/msm8998.dtsi
> +++ b/arch/arm64/boot/dts/qcom/msm8998.dtsi
> @@ -1599,9 +1599,8 @@ remoteproc_slpi: remoteproc@5800000 {
>   
>   			px-supply = <&vreg_lvs2a_1p8>;
>   
> -			clocks = <&rpmcc RPM_SMD_XO_CLK_SRC>,
> -				 <&rpmcc RPM_SMD_AGGR2_NOC_CLK>;
> -			clock-names = "xo", "aggre2";
> +			clocks = <&rpmcc RPM_SMD_XO_CLK_SRC>;
> +			clock-names = "xo";
>   
>   			memory-region = <&slpi_mem>;
>   
> 

