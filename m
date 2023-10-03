Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1AF1E7B66AC
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 12:45:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231846AbjJCKpS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 06:45:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231769AbjJCKpR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 06:45:17 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95935BF
        for <linux-kernel@vger.kernel.org>; Tue,  3 Oct 2023 03:45:13 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7026CC433CA;
        Tue,  3 Oct 2023 10:45:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696329913;
        bh=JtcTWQxKGWwZqgm+l2lYgbyA83rSYz+5KPoIJRXClqs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lQk5DIi8st3IxeEoWswm+LZCDSJ1umvNGVAkWJDdNFUEjdE5B4Kejz/vXEoYDEoSc
         0BgkVJx4ZdD9nmn481cjzkD4gsWUb+w7Ec/Ywiur2aabCOi0k2RykuiOH3ipz6YsWD
         7hq9dEGEmCiV0+8he9Xar6k+PrxtIY49JRP7TmDmifVG12Iv+8WXun32SkqKRdmvd4
         G0mJ8QGb+2PVSV6LerHokZUK9Jhw4mD9crcmCttr/EELnb0xHigjja/ee4o1e6zWNw
         TxHBnjJDMQRA39KygOx9hwrenCopAGtslqyDSEKrqAwQKH1TilbSH79xc+scE8cpa+
         RGehgD5Bx9nQQ==
Date:   Tue, 3 Oct 2023 12:45:08 +0200
From:   Simon Horman <horms@kernel.org>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     linux-kernel@vger.kernel.org,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH] page_pool: fix documentation typos
Message-ID: <ZRvwtGG7hZSda3AM@kernel.org>
References: <20231001003846.29541-1-rdunlap@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231001003846.29541-1-rdunlap@infradead.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 30, 2023 at 05:38:45PM -0700, Randy Dunlap wrote:
> Correct grammar for better readability.
> 
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>

Reviewed-by: Simon Horman <horms@kernel.org>

