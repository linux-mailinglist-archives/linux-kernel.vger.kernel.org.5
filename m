Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D8DB7D22DA
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Oct 2023 13:19:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231572AbjJVLTj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Oct 2023 07:19:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229588AbjJVLTi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Oct 2023 07:19:38 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0120AE5
        for <linux-kernel@vger.kernel.org>; Sun, 22 Oct 2023 04:19:35 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43F39C433C8;
        Sun, 22 Oct 2023 11:19:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1697973575;
        bh=YmgDNED23ixJ3o/WNflKhXgCQTh55NXblC0T6yCsHYw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=pyu+qBCPcvvAGFI/oGySCM6BdPCB23aZHzRIPMG/fYw7Esav0xmq2QIhub2a4Ku7t
         Plvq4+mDFJL/MU7QkEkDdGftdqxg+tCSP1pZdQaoQwIzC+a3FN0VlNJCEwwBQhTmk6
         d0JC9j+o4r4t2FYkVgAGQKTcZhDokxBNXjyLIgXM=
Date:   Sun, 22 Oct 2023 13:19:33 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Nandha Kumar Singaram <nandhakumar.singaram@gmail.com>
Cc:     Viresh Kumar <vireshk@kernel.org>, Johan Hovold <johan@kernel.org>,
        Alex Elder <elder@kernel.org>, greybus-dev@lists.linaro.org,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        kumaran.4353@gmail.com
Subject: Re: [PATCH 3/3] staging: greybus: fixed prefer using ftrace warning
Message-ID: <2023102219-boat-shaky-f491@gregkh>
References: <cover.1697969950.git.nandhakumar.singaram@gmail.com>
 <cade10d4b94127900a015e0b2ab94da5dd8c2c63.1697969950.git.nandhakumar.singaram@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cade10d4b94127900a015e0b2ab94da5dd8c2c63.1697969950.git.nandhakumar.singaram@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 22, 2023 at 03:42:26AM -0700, Nandha Kumar Singaram wrote:
> Adhere to linux coding style. Reported by checkpatch.pl:
> WARNING: Unnecessary ftrace-like logging - prefer using ftrace
> 
> Signed-off-by: Nandha Kumar Singaram <nandhakumar.singaram@gmail.com>
> ---
>  drivers/staging/greybus/bootrom.c | 2 --
>  1 file changed, 2 deletions(-)

Again, subject line should have "bootrom" in there somewhere, right?

thanks,

greg k-h
