Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70CD27F2BAC
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 12:25:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233854AbjKULZL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 06:25:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230256AbjKULZI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 06:25:08 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 893D8CB
        for <linux-kernel@vger.kernel.org>; Tue, 21 Nov 2023 03:25:05 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9BB51C433C8;
        Tue, 21 Nov 2023 11:25:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1700565905;
        bh=TbPcnZPxnGe9plFdKanhkx7U7DgBVbiQezneWX/9tcU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=I9W1Cuuu3o9xwgJoI7weqFwtc0MSIicVUSfWNo/cza9ZTBN09AZW+1eJ6zK+vqbeq
         cQDBLLd7Vi+/IqRYLpSjMdXVoX+lRwT5OWaky6WBk0V83NGJx9Pryrbv0RA2tEPel0
         h8UahsOh9T1Al0bXC9DQlH7y3WfnFCqkCem2GVBU=
Date:   Tue, 21 Nov 2023 12:25:01 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Sprite <spriteovo@gmail.com>
Cc:     johan@kernel.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, Yangyu Chen <cyy@cyyself.name>
Subject: Re: [PATCH] USB: serial: option: add Luat Air72*U series products
Message-ID: <2023112128-spinach-quit-0d8a@gregkh>
References: <20231121111626.64804-1-SpriteOvO@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231121111626.64804-1-SpriteOvO@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Co-developed-by: Yangyu Chen <cyy@cyyself.name>
> Signed-off-by: Yangyu Chen <cyy@cyyself.name>
> Signed-off-by: Sprite <SpriteOvO@gmail.com>

"Sprite" is an odd name, is that how things are signed by you?

thanks,

greg k-h
