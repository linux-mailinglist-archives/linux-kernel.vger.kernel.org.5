Return-Path: <linux-kernel+bounces-4525-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B7B0817EDA
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 01:32:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C2E551C21F46
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 00:32:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6411D15C3;
	Tue, 19 Dec 2023 00:31:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="GRiVoeHR"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9DA67E5;
	Tue, 19 Dec 2023 00:31:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 3BINqgs2030360;
	Tue, 19 Dec 2023 00:31:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:mime-version:content-type; s=
	qcppdkim1; bh=cMdDpIkyV1tBSSRYfF1W750REpM6Se4BMzT6zO41Xi4=; b=GR
	iVoeHR5OwrwVeDunBu08FzP9EKTWm0f+D7kR0fHdWBimtfiyffuhIpf7MQya7a4w
	mEQd0jfZRDSMxnsw7okwNijCwWmgvg3j1iaV44i2qNyzxAZf9Y8dgQ8k4Z3OjQaz
	RZtq49RjUaxkhrPToYWZGRO3QD1T6HALX78J0EWC+MsWBSAQzZnWsPsgbfWpINCv
	Wf3VRdqRdbTRkBLuDCqZCjv1Z/esb6O7dTHmSxxybJ1LaFGUJbfa+pzKVWszS903
	nUguhh3F67hZASkkzYNvXr2greiWCwuU16FyLRynn0vllAslhldk4Yvij2ePzQ9A
	QbWbmiq13S7/AEvmomrg==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3v2nxs9qbp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 19 Dec 2023 00:31:46 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3BJ0VkkN015238
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 19 Dec 2023 00:31:46 GMT
Received: from tengfan2-gv.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Mon, 18 Dec 2023 16:31:39 -0800
From: Tengfei Fan <quic_tengfan@quicinc.com>
To: <andersson@kernel.org>, <konrad.dybcio@linaro.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>
CC: <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <kernel@quicinc.com>,
        Tengfei Fan
	<quic_tengfan@quicinc.com>
Subject: [PATCH v3 0/1] arm64: dts: qcom: sm8550: remove
Date: Tue, 19 Dec 2023 08:31:05 +0800
Message-ID: <20231219003106.8663-1-quic_tengfan@quicinc.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: pcGKejz5Z1psB9tCCsfAw7n6DsUqN5TD
X-Proofpoint-ORIG-GUID: pcGKejz5Z1psB9tCCsfAw7n6DsUqN5TD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_01,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=4 mlxlogscore=135
 malwarescore=0 bulkscore=0 phishscore=0 spamscore=4 mlxscore=4
 impostorscore=0 priorityscore=1501 clxscore=1015 suspectscore=0
 adultscore=0 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2311290000 definitions=main-2312190002

The address/size-cells in mdss_dsi1 node have not ranges and child also
have not reg, then this leads to dtc W=1 warnings:

  sm8550.dtsi:2937.27-2992.6: Warning (avoid_unnecessary_addr_size): /soc@0/display-subsystem@ae00000/dsi@ae96000:
    unnecessary #address-cells/#size-cells without "ranges" or child "reg" property

Signed-off-by: Tengfei Fan <quic_tengfan@quicinc.com>
---

v2 -> v3:
  - separate this patch from other patch series
v1 -> v2:
  - add reviewed-by tage due to patch review done

previous discussion here:
[1] v2: https://lore.kernel.org/linux-arm-msm/20231207092801.7506-4-quic_tengfan@quicinc.com
[2] v1: https://lore.kernel.org/linux-arm-msm/20231117101817.4401-6-quic_tengfan@quicinc.com

Tengfei Fan (1):
  arm64: dts: qcom: sm8550: remove address/size-cells from mdss_dsi1

 arch/arm64/boot/dts/qcom/sm8550.dtsi | 3 ---
 1 file changed, 3 deletions(-)


base-commit: ceb2fe0d438644e1de06b9a6468a1fb8e2199c70
-- 
2.17.1


