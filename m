Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50C257E86F9
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Nov 2023 01:39:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230196AbjKKAjI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Nov 2023 19:39:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229560AbjKKAjH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Nov 2023 19:39:07 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E86DC3C3D;
        Fri, 10 Nov 2023 16:39:03 -0800 (PST)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AB0K4e3024678;
        Sat, 11 Nov 2023 00:38:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=Y6r0UHon3q8rn/jGHAPfVTSmLPFbIaTGUL112a4ldAM=;
 b=MRZqAxjKig8hdYAtWXTt4u3VdnrSg+h+LpncEG7HMh5RBGyk/xSr5p3DRItOK3ue56TO
 RyiNEqbsxj71QPOTOqB0/nkQ7ytWl03qGAm/0oHpzZOQBxOTVUsSl+XeQghO8rieUgi1
 B3CtmnyYZea1QIu/0CWx4sdkfUTRodlbvx4HzrpwPtJRsxNuQ7p2OOD/QLfSlT3Z8tRK
 e+v9DxFJyO8QxZZQbQgFRJTy3F3OF8DjDORFmbxFATQbw6En5ty/M/MJTCQivBcPnk/p
 +ME1rz+rO0n4FJv39F29UWfVGcB1VzNuAu4Uk37LQgjd0KoUCp+D1N3DcsjHfZzx4nV8 IA== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3u9h9va141-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 11 Nov 2023 00:38:58 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3AB0cviT031705
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 11 Nov 2023 00:38:57 GMT
Received: from [10.110.6.241] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.39; Fri, 10 Nov
 2023 16:38:56 -0800
Message-ID: <76eeb452-dd61-44ce-ae9c-a8f8afa83fb8@quicinc.com>
Date:   Fri, 10 Nov 2023 16:38:55 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mwifiex: clean up some inconsistent indenting
Content-Language: en-US
To:     Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
        <briannorris@chromium.org>
CC:     <kvalo@kernel.org>, <linux-wireless@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Abaci Robot <abaci@linux.alibaba.com>
References: <20231110083327.7022-1-jiapeng.chong@linux.alibaba.com>
From:   Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <20231110083327.7022-1-jiapeng.chong@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: mVg7v09LYon4zmtThHv4UEIZV0i9p9YN
X-Proofpoint-ORIG-GUID: mVg7v09LYon4zmtThHv4UEIZV0i9p9YN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-10_21,2023-11-09_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 mlxlogscore=976 adultscore=0 lowpriorityscore=0 spamscore=0 phishscore=0
 suspectscore=0 bulkscore=0 impostorscore=0 clxscore=1011
 priorityscore=1501 mlxscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2311060000 definitions=main-2311110003
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/10/2023 12:33 AM, Jiapeng Chong wrote:
> No functional modification involved.
> 
> drivers/net/wireless/marvell/mwifiex/sta_event.c:789 mwifiex_process_sta_event() warn: inconsistent indenting.
> 
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Closes: https://bugzilla.openanolis.cn/show_bug.cgi?id=7226
> Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
> ---
>  drivers/net/wireless/marvell/mwifiex/sta_event.c | 14 ++++++--------
>  1 file changed, 6 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/net/wireless/marvell/mwifiex/sta_event.c b/drivers/net/wireless/marvell/mwifiex/sta_event.c
> index df9cdd10a494..9dd3b6d71026 100644
> --- a/drivers/net/wireless/marvell/mwifiex/sta_event.c
> +++ b/drivers/net/wireless/marvell/mwifiex/sta_event.c
> @@ -762,7 +762,7 @@ int mwifiex_process_sta_event(struct mwifiex_private *priv)
>  		mwifiex_dbg(adapter, EVENT, "info: EVENT: AWAKE\n");
>  		if (!adapter->pps_uapsd_mode &&
>  		    (priv->port_open ||
> -		     (priv->bss_mode == NL80211_IFTYPE_ADHOC)) &&
> +		    (priv->bss_mode == NL80211_IFTYPE_ADHOC)) &&

this change looks incorrect to me
this condition is *inside* the parenthesis from the beginning of the
previous line, and hence this should align after that parenthesis, not
with that parenthesis, which is what the existing code is doing

>  		    priv->media_connected && adapter->sleep_period.period) {
>  			adapter->pps_uapsd_mode = true;
>  			mwifiex_dbg(adapter, EVENT,
> @@ -773,7 +773,7 @@ int mwifiex_process_sta_event(struct mwifiex_private *priv)
>  			if (mwifiex_check_last_packet_indication(priv)) {
>  				if (adapter->data_sent ||
>  				    (adapter->if_ops.is_port_ready &&
> -				     !adapter->if_ops.is_port_ready(priv))) {
> +				    !adapter->if_ops.is_port_ready(priv))) {

same thing here

>  					adapter->ps_state = PS_STATE_AWAKE;
>  					adapter->pm_wakeup_card_req = false;
>  					adapter->pm_wakeup_fw_try = false;

