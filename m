Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79E8280E622
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 09:29:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231132AbjLLI24 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 03:28:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231236AbjLLI2o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 03:28:44 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE8F71991
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 00:26:09 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D72DC433C7;
        Tue, 12 Dec 2023 08:25:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1702369533;
        bh=UyrCZ5NeqkIbDqZ4IfzKB2v4FwYYwyufuxet/S+xQZg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=y0tTobdaLmy4VCh/NwI9a3Snubd38cOqAeFoPopo7s4MuUU8zj92krFHmnPOxV22x
         gpap/U1YH6sUfKArJWBVkst/TOgQIYPkRkI1wKdzDCUWhPBIZN+Lj+WfWr85YYx5z9
         urcYYae/Sc5eiRb35t0jXR6xHCqsAW/yosWauCtE=
Date:   Tue, 12 Dec 2023 09:25:31 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     shitao <shitao@kylinos.cn>
Cc:     justin.chen@broadcom.com, alcooperx@gmail.com,
        chunfeng.yun@mediatek.com, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
        k2ci <kernel-bot@kylinos.cn>
Subject: Re: [PATCH] usb: fix comment typos
Message-ID: <2023121249-swan-steep-dc94@gregkh>
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

What is this?  It needs to be documented better, sorry.

thanks,

greg k-h
