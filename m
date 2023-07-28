Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F4E77664FC
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 09:14:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233529AbjG1HOc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 03:14:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233294AbjG1HO3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 03:14:29 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51B382129;
        Fri, 28 Jul 2023 00:14:28 -0700 (PDT)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36S5qnfw025735;
        Fri, 28 Jul 2023 07:14:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=date : from : to :
 cc : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=qcppdkim1; bh=NJWZbB4p4f7NlmJ773iMZcduZEE57dEBdDATiNslBhE=;
 b=GB17Ti235fVwJGD/U6KKuqIdI6RZlZjJ6zaM6bXiQqZU04cKrc71tuNvE5ZkNvlSRd3/
 YMLIErfc5yMYDVL1D/xXNn2/e9df/zpoZzHUq8YMVLxluBG8I0fvC76/gvjvP1QHk3ok
 vXhCqDpdwA9+D0ysOQ8uYsYXdhehbejH/eWM7CMl5gnGzh8I6s+SPAUtP5qh+1T7FH6F
 bQuMUnpuanoN4Eo1LyKbPzHVs9XdII8wfwJS0DXuFUhdzpiIL/GU/tmDMH6cPF5twkOI
 RglAYDZpG6oWjZ/IlpEg4CLcc9i5IAdD0ldKLjP3B0X3Zk6iNnz40SB2v9KhOsw2Ni7E zA== 
Received: from nasanppmta05.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3s468r095s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 28 Jul 2023 07:14:20 +0000
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
        by NASANPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 36S7EJ1A008576
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 28 Jul 2023 07:14:19 GMT
Received: from quicinc.com (10.80.80.8) by nasanex01b.na.qualcomm.com
 (10.46.141.250) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.30; Fri, 28 Jul
 2023 00:14:19 -0700
Date:   Fri, 28 Jul 2023 00:14:18 -0700
From:   Guru Das Srinagesh <quic_gurus@quicinc.com>
To:     Mukesh Ojha <quic_mojha@quicinc.com>
CC:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        "Lee Jones" <lee@kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>
Subject: Re: [PATCH] treewide: Update Guru Das Srinagesh's email address
Message-ID: <20230728071418.GA31385@quicinc.com>
References: <20230728001622.4938-1-quic_gurus@quicinc.com>
 <01ef5a38-3902-6581-affa-eb68ba8b0d04@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <01ef5a38-3902-6581-affa-eb68ba8b0d04@quicinc.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: tMOAIAJT01W7YK_WgP5LEECb9eTRlkD_
X-Proofpoint-ORIG-GUID: tMOAIAJT01W7YK_WgP5LEECb9eTRlkD_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-27_10,2023-07-26_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 mlxlogscore=671
 bulkscore=0 adultscore=0 malwarescore=0 spamscore=0 suspectscore=0
 mlxscore=0 priorityscore=1501 lowpriorityscore=0 impostorscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2307280064
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Jul 28 2023 11:33, Mukesh Ojha wrote:
> Just a question, is this still needed after below change ?
> 
> https://lore.kernel.org/lkml/20230720210256.1296567-1-quic_bjorande@quicinc.com/

Thank you - I wasn't aware of this patch from Bjorn. Nevertheless, I would like
to get my patch merged just for correctness' sake. I leave it to the
maintainers to take the final call on this.

Guru Das.
