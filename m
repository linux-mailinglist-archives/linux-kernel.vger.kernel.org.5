Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBBE77DA3F1
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Oct 2023 01:05:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346712AbjJ0XFg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Oct 2023 19:05:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230451AbjJ0XFe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Oct 2023 19:05:34 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64E7C129;
        Fri, 27 Oct 2023 16:05:32 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9ED63C433C7;
        Fri, 27 Oct 2023 23:05:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698447932;
        bh=NE+81gfyy96xKk7IPcqnToO7uQkc2vbU5rV52eM5mvk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=kA7lzF9EFrorsFxlsI39nNjDJCQiBFQ3pTy+JoPwRX9FGkdE+mZ9v/WEvVyDRLcL3
         XlAVb4Jtaibz/vb775fnQs6BELMUNHQsCx5RyBR0UdxAJbcTu3FT7A+pf67z9/PuK7
         O8yoj6zWb6EQC11R2Ez0AQbMDXDOQlhFcVxGrKnh0jkXnJzjqU9ocF3jH47HgdVczN
         MnKilTW9YIKH5h/lBwP7LGcTpAJ/bANYABP6QxRzSiDNExHTeTbuFpXwY2hmMOPvCC
         AyD1QntogF4ZKBu4ulPT+KkBbmPcnupD0qKv86VrEAgo38Q/3FPl9ptVfS35BFeP0O
         t/9jqQXjTdluQ==
Date:   Fri, 27 Oct 2023 16:05:30 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Colin Ian King <colin.i.king@gmail.com>
Cc:     Woojung Huh <woojung.huh@microchip.com>,
        UNGLinuxDriver@microchip.com, Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Vladimir Oltean <olteanv@gmail.com>,
        "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][next] net: dsa: microchip: ksz9477: Fix spelling
 mistake "Enery" -> "Energy"
Message-ID: <20231027160530.5cc4ef5d@kernel.org>
In-Reply-To: <20231026065408.1087824-1-colin.i.king@gmail.com>
References: <20231026065408.1087824-1-colin.i.king@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 26 Oct 2023 07:54:08 +0100 Colin Ian King wrote:
> There is a spelling mistake in a dev_dbg message. Fix it.
> 
> Signed-off-by: Colin Ian King <colin.i.king@gmail.com>

Applied, thanks.
-- 
pw-bot: accept
