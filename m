Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55B707C46DE
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 02:51:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344542AbjJKAvU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 20:51:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344281AbjJKAvS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 20:51:18 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F77F92
        for <linux-kernel@vger.kernel.org>; Tue, 10 Oct 2023 17:51:16 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84141C433C7;
        Wed, 11 Oct 2023 00:51:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696985476;
        bh=vxagm5mK607K1KreDirna2dD/CK2JhYIxlpdgn72yes=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=hGX01UlXN7PUeh/rezNXICkNgkjChpyI7T1lSJIxsBZ03gbV4EZDey3D+XYeEqAjc
         LCrgxfK3gksFWVkYuIByNSlS+2ImCZGqghANtNOsYJGfdqzGAQdRqL/EE5cv4IfI4a
         LI2I9zyxyYAAlfjmNe4UGCEzjWbofyJzi6jIMs4VyJQ6mofGFHzMwC2E8HMO8wjxsa
         ceop5zUUTXcZXhfapjpJOBs467S8Y3B05siP83wvKKhOZ+03qW8y3LgYG4WdYxRL/f
         k1bmzWHnl1ziWwY75VoioFlelLwo40H7anw9+gf3g311zAPeyU6DQRdjHa+u/LHgoB
         fp5BVVXdDJt9Q==
Date:   Tue, 10 Oct 2023 17:51:14 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>, Doug Brown <doug@schmorgal.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] appletalk: remove ipddp driver
Message-ID: <20231010175114.40014532@kernel.org>
In-Reply-To: <20231009141139.1766345-1-arnd@kernel.org>
References: <20231009141139.1766345-1-arnd@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon,  9 Oct 2023 16:10:28 +0200 Arnd Bergmann wrote:
>  Documentation/networking/ipddp.rst |  78 -------

I dropped this file from the index when applying.
