Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BE0476A89C
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 08:02:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231265AbjHAGCS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 02:02:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231238AbjHAGCK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 02:02:10 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A36B1FD2;
        Mon, 31 Jul 2023 23:02:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C3E956146F;
        Tue,  1 Aug 2023 06:02:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 178E1C433C8;
        Tue,  1 Aug 2023 06:02:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690869726;
        bh=JiTXGLYJWPJsg2TfI3p8egkq8itI6r7RrUkb+0gpOKQ=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=m+rxfq4V/I0DfPvvwO/NW44g6r3HcAX81KglDqByLhm/0nfB6A8Jj54OQrHE6vJKl
         7KZOSe1AkHmbGGlvCzaQbyuchARp7aRcRQUBedNk/f38I3NyHg9N1pBd6D+iO0MvSy
         okOWvNZn9PNdqCjNEXHTPiI/hLJZmlgKDS3TqhRDzyDD3K/dAnUiTDcmWl0fnrmgrc
         EieY1XAhzOMUUxfsL7kHW0WuJili3BeHnTaYscztcp2JY9nxj2vqATJ3NC3ZxTm8DG
         z17YW0Fv4u+KGq4U/yYlVD6b9SbO5x4QYEAzIHEHF0ofddGndIEfT0ZaW7xdMQk2uU
         GgisnK/0dXEtQ==
From:   Kalle Valo <kvalo@kernel.org>
To:     Yue Haibing <yuehaibing@huawei.com>
Cc:     <johannes@sipsolutions.net>, <davem@davemloft.net>,
        <edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
        <nbd@nbd.name>, <pagadala.yesu.anjaneyulu@intel.com>,
        <linux-wireless@vger.kernel.org>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] mac80211: mesh: Remove unused function declaration
 mesh_ids_set_default()
References: <20230731140712.1204-1-yuehaibing@huawei.com>
Date:   Tue, 01 Aug 2023 09:02:22 +0300
In-Reply-To: <20230731140712.1204-1-yuehaibing@huawei.com> (Yue Haibing's
        message of "Mon, 31 Jul 2023 22:07:12 +0800")
Message-ID: <87jzufz4ep.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Yue Haibing <yuehaibing@huawei.com> writes:

> Commit ccf80ddfe492 ("mac80211: mesh function and data structures definitions")
> introducted this but never implemented.
>
> Signed-off-by: Yue Haibing <yuehaibing@huawei.com>
> ---
>  net/mac80211/mesh.h | 1 -
>  1 file changed, 1 deletion(-)

The title should have "wifi:" but no need to resend because of this.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
