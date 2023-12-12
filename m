Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D69A80E650
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 09:36:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346037AbjLLIgK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 03:36:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346137AbjLLIft (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 03:35:49 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6A076FBB
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 00:26:22 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85825C433C9;
        Tue, 12 Dec 2023 08:25:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1702369548;
        bh=3a9AxDt7rKdnQt1lB7x7eM9PZxjgwdVCfCxEm49JQi0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ga8GfI4RYaUAlSj8fu+eIRYZS/vv75ipHwGI5bbnI4pXxIrSlsTzwVHl4zqa5cF0u
         NtqxzH+P39uUeVJ9XrXiWb+8Vnh5+BmDbhh80sKcdyyjccCE5gBl0lxyuJCI5xo5zh
         d2eombqosAAEVyS7L4d1kPhT8jKw68sc3vo3Pj7E=
Date:   Tue, 12 Dec 2023 09:25:46 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     shitao <shitao@kylinos.cn>
Cc:     justin.chen@broadcom.com, alcooperx@gmail.com,
        chunfeng.yun@mediatek.com, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
        k2ci <kernel-bot@kylinos.cn>
Subject: Re: [PATCH] usb: fix comment typos
Message-ID: <2023121236-earful-email-ea09@gregkh>
References: <20231212074557.3100489-1-shitao@kylinos.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231212074557.3100489-1-shitao@kylinos.cn>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 12, 2023 at 03:45:57PM +0800, shitao wrote:
> Fix two comment typos in usb module files.
> 
> Reported-by: k2ci <kernel-bot@kylinos.cn>
> Signed-off-by: shitao <shitao@kylinos.cn>
> ---
>  drivers/usb/gadget/udc/bdc/bdc_core.c | 2 +-
>  drivers/usb/mtu3/mtu3_qmu.c           | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)

Also why isn't this two different patches?

thanks,

greg k-h
