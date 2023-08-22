Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DC807847E6
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 18:43:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237731AbjHVQnZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Aug 2023 12:43:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237633AbjHVQnY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Aug 2023 12:43:24 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88D9219A;
        Tue, 22 Aug 2023 09:43:22 -0700 (PDT)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37MDeZZM031343;
        Tue, 22 Aug 2023 16:43:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=mlSWk71yM9xUaZnpXT/Q1N2oMgLN+cIe0+IPoVD9dmY=;
 b=ikQ9bKCpG8/xCp3W/IQQhoagLGd/zpsAWWKfqwIyEr/JxUyCmYeUyOOTfqMpLHTzjhWS
 Y51p6vG3yiPU5AlSUahQ2c6Fdy5hNCQ/yuKMth4gFb9Kp0L4MacrvjmORsR5yhkLkwCT
 Rw9Alxz5REG2fQX1tj27pwqhfKXkiqdPP+oMQKkoFHRCXKlyAJwQuO5vHQdfjAUdRRCP
 Rq/oKfNM9Kf9qZG6XfTlqNtH9slxyUilXse7DxmygppfgZoOI1CI1imQoWu32Hx9pYNR
 3XZJntd5e4rIjLp2616z8edpMdIGFx6KJWGaL7CIGD9t3eLkyYA3mtLdmZ8d1slVqDZ8 zg== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3smx300jgv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 22 Aug 2023 16:43:12 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 37MGhA2a014995
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 22 Aug 2023 16:43:10 GMT
Received: from [10.48.244.52] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.36; Tue, 22 Aug
 2023 09:43:10 -0700
Message-ID: <1a9f7b7b-6e99-4cbb-a2e1-c76ed6b90a1d@quicinc.com>
Date:   Tue, 22 Aug 2023 09:43:08 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] wifi: ath12k: Fix a few spelling errors
Content-Language: en-US
To:     Randy Dunlap <rdunlap@infradead.org>, Kalle Valo <kvalo@kernel.org>
CC:     <ath10k@lists.infradead.org>, <linux-wireless@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <ath11k@lists.infradead.org>,
        <ath12k@lists.infradead.org>
References: <20230822-ath_spelling-v1-0-8e2698759564@quicinc.com>
 <20230822-ath_spelling-v1-3-8e2698759564@quicinc.com>
 <768de9a1-b186-c296-e9b9-d83cee1997a6@infradead.org>
From:   Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <768de9a1-b186-c296-e9b9-d83cee1997a6@infradead.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01c.na.qualcomm.com (10.47.97.35) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: Al7zSsMj33klfJC2fkVgf9Z78bHZT7-I
X-Proofpoint-GUID: Al7zSsMj33klfJC2fkVgf9Z78bHZT7-I
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-22_13,2023-08-22_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 clxscore=1011
 adultscore=0 mlxlogscore=999 priorityscore=1501 impostorscore=0 mlxscore=0
 phishscore=0 suspectscore=0 spamscore=0 bulkscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2306200000
 definitions=main-2308220131
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/22/2023 9:18 AM, Randy Dunlap wrote:
> Hi--
> 
> On 8/22/23 07:50, Jeff Johnson wrote:
>> Fix a few issues flagged by 'codespell'.
>>
>> Signed-off-by: Jeff Johnson <quic_jjohnson@quicinc.com>
>> ---
>>   drivers/net/wireless/ath/ath12k/dp.h      | 2 +-
>>   drivers/net/wireless/ath/ath12k/dp_rx.c   | 2 +-
>>   drivers/net/wireless/ath/ath12k/dp_tx.c   | 2 +-
>>   drivers/net/wireless/ath/ath12k/mac.c     | 2 +-
>>   drivers/net/wireless/ath/ath12k/rx_desc.h | 2 +-
>>   5 files changed, 5 insertions(+), 5 deletions(-)
>>
>> diff --git a/drivers/net/wireless/ath/ath12k/mac.c b/drivers/net/wireless/ath/ath12k/mac.c
>> index 0f2af2f14ef7..dbaf033c2527 100644
>> --- a/drivers/net/wireless/ath/ath12k/mac.c
>> +++ b/drivers/net/wireless/ath/ath12k/mac.c
>> @@ -6771,7 +6771,7 @@ ath12k_mac_op_reconfig_complete(struct ieee80211_hw *hw,
>>   			/* After trigger disconnect, then upper layer will
>>   			 * trigger connect again, then the PN number of
>>   			 * upper layer will be reset to keep up with AP
>> -			 * side, hence PN number mis-match will not happened.
>> +			 * side, hence PN number mismatch will not happened.
> 
> The fix is good, but preferably also s/happened/happen/.

Kalle, can you apply that when it goes to -pending?

> 
>>   			 */
>>   			if (arvif->is_up &&
>>   			    arvif->vdev_type == WMI_VDEV_TYPE_STA &&
> 

