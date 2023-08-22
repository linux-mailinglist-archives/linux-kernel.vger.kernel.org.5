Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 641287849FC
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 21:10:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230034AbjHVTK4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Aug 2023 15:10:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230035AbjHVTKy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Aug 2023 15:10:54 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CC77CD1;
        Tue, 22 Aug 2023 12:10:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D9A3C6235C;
        Tue, 22 Aug 2023 19:10:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B69E6C433C7;
        Tue, 22 Aug 2023 19:10:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692731452;
        bh=nr4GjTppWgFW9yVzV6ogm5jejxBqzeEjyQ/mmPg7ulM=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=Iz566OCHSbLw3VM4P7vq7Fm1TDtZBmofK6vRl/IpLuSGhx2AUYPn/lT2kKfGWGcBN
         /hDiBfPSXCfQo+c3a8Zg5RQ6kKgF/5reMx7136YY87GnpSjVE/fEa3VaDGXTO5o35W
         kY1YjAW0yPnxsHXKp/sA7IDwtaHodn4188umUrevKX0ZTCpowonW2fLQ5AVpyKsZW2
         i50Xt56Q6K28J2inoQ9QA8iUAIp/wPg5GAbubfhAbEL0XwPBACLt/RCJ7ke6owZbWi
         K02rVDiHHxjMJjJig0iGylQhyBIW40PAgJPwRZE6Uzgi7IZG0V5Any/uJnu5d28AS7
         9k427Nh6gRpNg==
From:   Kalle Valo <kvalo@kernel.org>
To:     Jeff Johnson <quic_jjohnson@quicinc.com>
Cc:     Randy Dunlap <rdunlap@infradead.org>, <ath10k@lists.infradead.org>,
        <linux-wireless@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <ath11k@lists.infradead.org>, <ath12k@lists.infradead.org>
Subject: Re: [PATCH 3/3] wifi: ath12k: Fix a few spelling errors
References: <20230822-ath_spelling-v1-0-8e2698759564@quicinc.com>
        <20230822-ath_spelling-v1-3-8e2698759564@quicinc.com>
        <768de9a1-b186-c296-e9b9-d83cee1997a6@infradead.org>
        <1a9f7b7b-6e99-4cbb-a2e1-c76ed6b90a1d@quicinc.com>
Date:   Tue, 22 Aug 2023 22:10:48 +0300
In-Reply-To: <1a9f7b7b-6e99-4cbb-a2e1-c76ed6b90a1d@quicinc.com> (Jeff
        Johnson's message of "Tue, 22 Aug 2023 09:43:08 -0700")
Message-ID: <87y1i2hozr.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Johnson <quic_jjohnson@quicinc.com> writes:

> On 8/22/2023 9:18 AM, Randy Dunlap wrote:
>
>> Hi--
>> On 8/22/23 07:50, Jeff Johnson wrote:
>>> Fix a few issues flagged by 'codespell'.
>>>
>>> Signed-off-by: Jeff Johnson <quic_jjohnson@quicinc.com>
>>> ---
>>>   drivers/net/wireless/ath/ath12k/dp.h      | 2 +-
>>>   drivers/net/wireless/ath/ath12k/dp_rx.c   | 2 +-
>>>   drivers/net/wireless/ath/ath12k/dp_tx.c   | 2 +-
>>>   drivers/net/wireless/ath/ath12k/mac.c     | 2 +-
>>>   drivers/net/wireless/ath/ath12k/rx_desc.h | 2 +-
>>>   5 files changed, 5 insertions(+), 5 deletions(-)
>>>
>>> diff --git a/drivers/net/wireless/ath/ath12k/mac.c b/drivers/net/wireless/ath/ath12k/mac.c
>>> index 0f2af2f14ef7..dbaf033c2527 100644
>>> --- a/drivers/net/wireless/ath/ath12k/mac.c
>>> +++ b/drivers/net/wireless/ath/ath12k/mac.c
>>> @@ -6771,7 +6771,7 @@ ath12k_mac_op_reconfig_complete(struct ieee80211_hw *hw,
>>>   			/* After trigger disconnect, then upper layer will
>>>   			 * trigger connect again, then the PN number of
>>>   			 * upper layer will be reset to keep up with AP
>>> -			 * side, hence PN number mis-match will not happened.
>>> +			 * side, hence PN number mismatch will not happened.
>> The fix is good, but preferably also s/happened/happen/.
>
> Kalle, can you apply that when it goes to -pending?

Yes, did that now:

https://git.kernel.org/pub/scm/linux/kernel/git/kvalo/ath.git/commit/?h=pending&id=212796e28fe44c0a4956c797d8b685b905784cd6

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
