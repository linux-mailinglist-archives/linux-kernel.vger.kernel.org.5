Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04FC3768703
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Jul 2023 20:07:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229865AbjG3SH0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Jul 2023 14:07:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229485AbjG3SHY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Jul 2023 14:07:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72EB5FB
        for <linux-kernel@vger.kernel.org>; Sun, 30 Jul 2023 11:07:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 113A060CEB
        for <linux-kernel@vger.kernel.org>; Sun, 30 Jul 2023 18:07:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EBEB1C433C7;
        Sun, 30 Jul 2023 18:07:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690740442;
        bh=iPW6Oi5yplI8WHOIzKrbqU9cTFrQcDMForF2HZJ/bWs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QOLmgKwkuwy9UpXyy5/a0iJONcWZOC4I3lRb/5iKmmo1FsxlokcR2CtS88dozbFMJ
         amW+wpcIIFauUn+AUq8i3A9j4+xpvuOpN9C4XT3UsCLjPo2VifgpaznutsNghU31py
         8e3U7VeIcx/ll0EjAjPrmyER0sPFxCKSDmx4FwTvHXMlpp3fpuQ7KJ9jgsc4dTV/RL
         AOJvGd/6dCNjHeGE9kwpiCTlkNJCDLp2UjUiDbWUaQb8FenJD6PQnR5XLvPZfdk4nB
         bj0ERtIHOQ/p5QQeIQ+fFmet9bu5Q7wYxFXeIQMZpxR9ZuE9fSzXbebA4zk7yllSnG
         vZRfwrP/4vUXg==
Date:   Sun, 30 Jul 2023 20:07:18 +0200
From:   Simon Horman <horms@kernel.org>
To:     Yue Haibing <yuehaibing@huawei.com>
Cc:     davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] net/hsr: Remove unused function declarations
Message-ID: <ZMam1gYzGbVJKL3m@kernel.org>
References: <20230729123456.36340-1-yuehaibing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230729123456.36340-1-yuehaibing@huawei.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 29, 2023 at 08:34:56PM +0800, Yue Haibing wrote:
> commit f421436a591d ("net/hsr: Add support for the High-availability Seamless Redundancy protocol (HSRv0)")
> introducted these but never implemented.
> 
> Signed-off-by: Yue Haibing <yuehaibing@huawei.com>

Reviewed-by: Simon Horman <horms@kernel.org>

