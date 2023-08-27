Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E6DA789D2E
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Aug 2023 13:12:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229580AbjH0LMA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Aug 2023 07:12:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229761AbjH0LLm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Aug 2023 07:11:42 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4B00109;
        Sun, 27 Aug 2023 04:11:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5932462713;
        Sun, 27 Aug 2023 11:11:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 620ECC433C8;
        Sun, 27 Aug 2023 11:11:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1693134699;
        bh=DNruZQ25zugxHCiqQhBbLwaBte33FLCQz4jP9Rqri8Q=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=iGCwqYNeueEdeg/8g6pvWwX5HY4EQEpuCxvPGcIR8Gefo+3h+09s8Lym7SLE1uKqL
         skLn2mFHkz7l2OZ56QsvlWNCdYdPUfwbeulS0ww3ovqle+V82lExCL9cIRgZTlwwlg
         +D9Mb2mCBZ/+uO6vaYAVy0q1JjcTMVj9UW5d/k7Q=
Date:   Sun, 27 Aug 2023 13:11:37 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Johan Hovold <johan@kernel.org>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL] USB-serial updates for 6.6-rc1
Message-ID: <2023082724-stainless-alfalfa-4ecc@gregkh>
References: <ZOsrmMtt5BTvfkcv@hovoldconsulting.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZOsrmMtt5BTvfkcv@hovoldconsulting.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 27, 2023 at 12:55:20PM +0200, Johan Hovold wrote:
> The following changes since commit fdf0eaf11452d72945af31804e2a1048ee1b574c:
> 
>   Linux 6.5-rc2 (2023-07-16 15:10:37 -0700)
> 
> are available in the Git repository at:
> 
>   https://git.kernel.org/pub/scm/linux/kernel/git/johan/usb-serial.git tags/usb-serial-6.6-rc1

Pulled and pushed out, thanks.

greg k-h
