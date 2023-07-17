Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3117756803
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 17:29:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230499AbjGQP3a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 11:29:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230189AbjGQP2f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 11:28:35 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1FA410C;
        Mon, 17 Jul 2023 08:28:33 -0700 (PDT)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36HCadCJ022923;
        Mon, 17 Jul 2023 15:28:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=MsIoX+H567PdkXdzrdTxRZhQxDXTwC8gl0+W+Fl7b64=;
 b=L2BtpfGNyxk30af53XWGwrPUqAVqDZ0XaPsOLzAuyqcxQouTO6u42DoERmZKdmplcAVJ
 IX9fVGVuEjC6O8yUKMhpxkwYmDQSYHgIn3wmtyWFUJsUONwJnEV/fR8sSXBtJFtqStzD
 9ZVd5eIakFJFdcVeroEVbqJdCqoO9AVVPZNYkLFMV9f3F1qTen50T26CHvWUKKpUbVnY
 K1yw60CLFJdkFlt5S7nUUH2MRzkp+A8DkP1oUryX7rbfItrRcT79gRs9YJE3rItbeYcc
 UG69NRggM1IL4VASLPmXu5ukc+Coq/uMrzF+oHPad9C7YOrG51/Wr67Zzbl4jSVrFWQU VA== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3run0auvt3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 17 Jul 2023 15:28:12 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 36HFSBmj025501
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 17 Jul 2023 15:28:11 GMT
Received: from [10.48.240.159] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.30; Mon, 17 Jul
 2023 08:28:10 -0700
Message-ID: <31018c49-44bc-5930-6c86-e1be95d71dc3@quicinc.com>
Date:   Mon, 17 Jul 2023 08:28:10 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] wcn36xx: remove space before ')'
Content-Language: en-US
To:     <hanyu001@208suo.com>, <kvalo@kernel.org>
CC:     <linux-wireless@vger.kernel.org>, <wcn36xx@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
References: <tencent_5D948ECE7946A4A04536C5EAD0B120565B07@qq.com>
 <f2d9a75e98698b245e5126eb425944a1@208suo.com>
From:   Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <f2d9a75e98698b245e5126eb425944a1@208suo.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01b.na.qualcomm.com (10.47.209.197) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: yuaxZPFCeeWg_wFO7Hl0iC4FAtrXfHuK
X-Proofpoint-ORIG-GUID: yuaxZPFCeeWg_wFO7Hl0iC4FAtrXfHuK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-17_12,2023-07-13_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 adultscore=0
 mlxlogscore=837 bulkscore=0 priorityscore=1501 mlxscore=0 suspectscore=0
 impostorscore=0 lowpriorityscore=0 clxscore=1011 spamscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2307170141
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/17/2023 12:04 AM, hanyu001@208suo.com wrote:
> Fixes checkpatch.pl error:
> 
> ./drivers/net/wireless/ath/wcn36xx/dxe.c:470: ERROR: space prohibited 
> before that close parenthesis ')'
> ./drivers/net/wireless/ath/wcn36xx/dxe.c:509: ERROR: space prohibited 
> before that close parenthesis ')'
> 
> Signed-off-by: maqimei <2433033762@qq.com>

For all of your recent patches you have the issue that your 
Signed-off-by does not seem to be a legal name, and that it does not 
match the From address in your e-mail.

Refer to 
<https://www.kernel.org/doc/html/latest/process/submitting-patches.html?highlight=signed%20off#sign-your-work-the-developer-s-certificate-of-origin>

Also all wifi drivers should have a subject prefix of "wifi: 
<drivername>:", in this case "wifi: wcn36xx: "

The actual patch LGTM

> ---
>   drivers/net/wireless/ath/wcn36xx/dxe.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/wireless/ath/wcn36xx/dxe.c 
> b/drivers/net/wireless/ath/wcn36xx/dxe.c
> index 9013f05..b8d7676 100644
> --- a/drivers/net/wireless/ath/wcn36xx/dxe.c
> +++ b/drivers/net/wireless/ath/wcn36xx/dxe.c
> @@ -467,7 +467,7 @@ static irqreturn_t wcn36xx_irq_tx_complete(int irq, 
> void *dev)
>                          WCN36XX_DXE_0_INT_CLR,
>                          WCN36XX_INT_MASK_CHAN_TX_H);
> 
> -        if (int_reason & WCN36XX_CH_STAT_INT_ERR_MASK ) {
> +        if (int_reason & WCN36XX_CH_STAT_INT_ERR_MASK) {
>               wcn36xx_dxe_write_register(wcn,
>                              WCN36XX_DXE_0_INT_ERR_CLR,
>                              WCN36XX_INT_MASK_CHAN_TX_H);
> @@ -506,7 +506,7 @@ static irqreturn_t wcn36xx_irq_tx_complete(int irq, 
> void *dev)
>                          WCN36XX_DXE_0_INT_CLR,
>                          WCN36XX_INT_MASK_CHAN_TX_L);
> 
> -        if (int_reason & WCN36XX_CH_STAT_INT_ERR_MASK ) {
> +        if (int_reason & WCN36XX_CH_STAT_INT_ERR_MASK) {
>               wcn36xx_dxe_write_register(wcn,
>                              WCN36XX_DXE_0_INT_ERR_CLR,
>                              WCN36XX_INT_MASK_CHAN_TX_L);

