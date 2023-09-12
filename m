Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08B4B79D3C5
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 16:33:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235974AbjILOd6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 10:33:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230502AbjILOdz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 10:33:55 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E75C110D;
        Tue, 12 Sep 2023 07:33:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=bdbJToXPqrJZvktSK692LxjlX/hRmiXWRSgU6Zq0vPw=; b=xusorWEAUV1BVs9U9Q8O2erAqO
        AXpndpqVjJ2YuEuB/OL1CRScPOgBiutxYjzIjKFPSU6tewgfKicCEmBdop1Tl6GW+jfY0SaHfyqrL
        kmPYNGNwxK/efbVHmmA8jCxRcT1ssEERDA2Nlc6A1JS73qG0WbMmTCbCKiMzNUAtJ3q7kL/gfd4ui
        HP2tKyeCoGBnp4TJWumEH2bYfxKgf7Z9192tc0nPzgXEI2zuXC4ys30oEFXM3jOwCLcsezuVwLGgl
        2spFJWUlUNdJf5ddKJ556vm83XnNA77aXV0MuMRCh6yBr6i19gnj3AY4Wy3oyyr2Okh9LU7g3rV1P
        i/K/HVgQ==;
Received: from [2601:1c2:980:9ec0::9fed]
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qg4SZ-003b0U-33;
        Tue, 12 Sep 2023 14:33:48 +0000
Message-ID: <caf312c4-b363-3b77-43f4-4abe9493c643@infradead.org>
Date:   Tue, 12 Sep 2023 07:33:45 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH][next] bcachefs: Fix a handful of spelling mistakes in
 various messages
Content-Language: en-US
To:     Colin Ian King <colin.i.king@gmail.com>,
        Kent Overstreet <kent.overstreet@linux.dev>,
        Brian Foster <bfoster@redhat.com>,
        linux-bcachefs@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230912082527.3913330-1-colin.i.king@gmail.com>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20230912082527.3913330-1-colin.i.king@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/12/23 01:25, Colin Ian King wrote:
> There are several spelling mistakes in error messages. Fix these.
> 
> Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
> ---
>  fs/bcachefs/alloc_background.c | 2 +-
>  fs/bcachefs/backpointers.c     | 2 +-
>  fs/bcachefs/btree_iter.c       | 2 +-
>  fs/bcachefs/fsck.c             | 2 +-
>  fs/bcachefs/recovery.c         | 2 +-
>  fs/bcachefs/snapshot.c         | 2 +-
>  fs/bcachefs/super-io.c         | 2 +-
>  7 files changed, 7 insertions(+), 7 deletions(-)
> 

LGTM. Thanks.

Acked-by: Randy Dunlap <rdunlap@infradead.org>

-- 
~Randy
