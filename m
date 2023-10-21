Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 312407D1C4B
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Oct 2023 11:53:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229803AbjJUJxR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 Oct 2023 05:53:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbjJUJxQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Oct 2023 05:53:16 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF1BDDF;
        Sat, 21 Oct 2023 02:53:10 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CDFA6C433C7;
        Sat, 21 Oct 2023 09:53:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1697881990;
        bh=mrT5GpV3SwVBG0NEQcFncjHx8JIGzumjfarKK3/zPpY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XQUfqk2XyDiusR+W6lW+Q18MRIBKR7ypUhuiYan+uDqIp52Vim3U2kkhAuYCMYjgp
         sErTKBDjrPw6IdDBjRJd6VvOhuaOW+fbsNUU0y8LbnaaSj7Mxm4Yd4BKzsGMDsEm3X
         +XggNO9HVx+GdUm4H0k9ZmJPD4F5BGib5CN/ndDs=
Date:   Sat, 21 Oct 2023 11:53:07 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Benjamin Poirier <benjamin.poirier@gmail.com>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
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
Message-ID: <2023102158-unison-depth-0db6@gregkh>
References: <20231020124457.312449-1-benjamin.poirier@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231020124457.312449-1-benjamin.poirier@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 20, 2023 at 08:44:55AM -0400, Benjamin Poirier wrote:
> Remove the qlge driver from staging. The TODO file is first updated to
> reflect the current status, in case the removal is later reverted.

Thanks for this, now applied!

greg k-h
