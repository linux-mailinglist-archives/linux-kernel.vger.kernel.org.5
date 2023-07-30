Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98E2A768511
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Jul 2023 13:24:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229973AbjG3LYn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Jul 2023 07:24:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbjG3LYm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Jul 2023 07:24:42 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4B6F10E9;
        Sun, 30 Jul 2023 04:24:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5D23460C07;
        Sun, 30 Jul 2023 11:24:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E543C433C8;
        Sun, 30 Jul 2023 11:24:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1690716280;
        bh=Pjf7d+qH0fhH+xZpi0geRtE2rw1HtHUoTWpBXrLFb/0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=RsC8ugMOBLV56QCLMPMn7HZ3tJ8NG/SMqUycr670BQoVbcEw+CVdoWrhE6URX0wUB
         vEM3d2ogVTREhCAoesY2qAuBpVfJNW0lbWtpCVPQCKRzhxbWPdv9a5FyVR633NjBuB
         LgDnuoOMP5aU7rgbly4IrS79+k7bUwQny7HQinYg=
Date:   Sun, 30 Jul 2023 13:24:37 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     surong pang <surong.pang@gmail.com>
Cc:     Surong Pang <surong.pang@unisoc.com>, Thinh.Nguyen@synopsys.com,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Orson.Zhai@unisoc.com, Zhiyong.liu@unisoc.com
Subject: Re: [PATCH] usb: dwc3: gadget: let pm runtime get/put paired
Message-ID: <2023073016-dart-phoenix-cd16@gregkh>
References: <20230728073919.6473-1-surong.pang@unisoc.com>
 <2023072844-ceremony-lushness-c229@gregkh>
 <CAEDbmASpaAbqnvykL0hjm-6fOGkNk55MkbTPMiD5f0BpVVzK3w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEDbmASpaAbqnvykL0hjm-6fOGkNk55MkbTPMiD5f0BpVVzK3w@mail.gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 29, 2023 at 04:43:13PM +0800, surong pang wrote:
> Dear Greg,
> The commit id is aad1a9ff2f53b8d5cde9ea07e1fd7eb7c20171ce

Wonderful, please resend with the proper Fixes: tag in the patch and we
will be glad to queue it up.

thanks,

greg k-h
