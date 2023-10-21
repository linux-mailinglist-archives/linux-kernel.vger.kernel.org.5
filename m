Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6554D7D19CF
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Oct 2023 02:07:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230146AbjJUAHn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Oct 2023 20:07:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229518AbjJUAHl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Oct 2023 20:07:41 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4577CD6D;
        Fri, 20 Oct 2023 17:07:39 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32AAFC433C8;
        Sat, 21 Oct 2023 00:07:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697846858;
        bh=jTrk/Gafm+KJRKpyzTt3v8OHqLErcuKfqpcSbk76V8I=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=vGVGdz8e43uV7R9ReOWlRBWvZ/wKZjDH63CXscVta7XkrF0cna+6PgPR+mZcn/oNY
         ISmxMTVY7NZAKrVavmowWG+SR/QPdYimd9mOJHWjSSY1a74gyH0OHk9Wo8URVj2wtI
         c1NT5jB0wbw64oGkfogxhXRP6XGe0YENctYcY6tg4IOvOTYyybpwTe7Fj4gsi2om/p
         wt7bflk0KrCKMrMkc14Dn04MG4M7irw7SFebvdk2s0h8+iqwntxGkfSriV8eqrxsqj
         atbY/Yd3ph/ab4y03YrU+8QILz8J1mRrQUH7LzsWFXNwDUh2sXHHImeSW4WBaHvQi8
         WeDLscDffY8Ig==
Date:   Fri, 20 Oct 2023 17:07:37 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Benjamin Poirier <benjamin.poirier@gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
        Helge Deller <deller@gmx.de>, Ian Kent <raven@themaw.net>,
        Sven Joachim <svenjoac@gmx.de>,
        Nandha Kumar Singaram <nandhakumar.singaram@gmail.com>,
        Sumitra Sharma <sumitraartsy@gmail.com>,
        Ricardo Lopes <ricardoapl.dev@gmail.com>,
        Dan Carpenter <error27@gmail.com>, netdev@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-parisc@vger.kernel.org, linux-staging@lists.linux.dev,
        Manish Chopra <manishc@marvell.com>,
        Coiby Xu <coiby.xu@gmail.com>
Subject: Re: [PATCH 0/2] staging: qlge: Remove qlge
Message-ID: <20231020170737.1036eae9@kernel.org>
In-Reply-To: <20231020124457.312449-1-benjamin.poirier@gmail.com>
References: <20231020124457.312449-1-benjamin.poirier@gmail.com>
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

On Fri, 20 Oct 2023 08:44:55 -0400 Benjamin Poirier wrote:
> Remove the qlge driver from staging. The TODO file is first updated to
> reflect the current status, in case the removal is later reverted.

Acked-by: Jakub Kicinski <kuba@kernel.org>

Thanks!
