Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A86E87F3193
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 15:49:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234787AbjKUOth (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 09:49:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234535AbjKUOtg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 09:49:36 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EADD90
        for <linux-kernel@vger.kernel.org>; Tue, 21 Nov 2023 06:49:33 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46AB4C433C8;
        Tue, 21 Nov 2023 14:49:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1700578173;
        bh=bldujqKviIOIMvPwKfmv7CG4Fmr04NgywnMf5OyqOH4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=1aCGz0SdDYpI6LnmjRqauIIpentHGRTjLdTX+IxHOFAQ4Wk/QEjdYD6oQErpg49ub
         jeMKtjOfp1MxqxVFF9ZZMb/+una9F2CRloOlueRuttfm22hcR77VM6VUcyIeSuHuJr
         MrsU2pITtqsxLGUqu3OYPLs0C0ejgoHTaKLE9Vfk=
Date:   Tue, 21 Nov 2023 14:52:24 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     SpriteOvO <spriteovo@gmail.com>
Cc:     johan@kernel.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, Yangyu Chen <cyy@cyyself.name>
Subject: Re: [PATCH] USB: serial: option: add Luat Air72*U series products
Message-ID: <2023112147-pegboard-discourse-9a31@gregkh>
References: <20231121111626.64804-1-SpriteOvO@gmail.com>
 <2023112128-spinach-quit-0d8a@gregkh>
 <7bdf5f7a-cdcd-46cc-88df-8bc0706ec9e9@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7bdf5f7a-cdcd-46cc-88df-8bc0706ec9e9@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 21, 2023 at 08:02:17PM +0800, SpriteOvO wrote:
> I've been using that name for a long time in open source communities, here's
> my GitHub profile:
> 
> https://github.com/SpriteOvO
> 
> Linux has allowed pseudonymous contributions since earlier this year, does
> this apply to me? If you are concerned that "Sprite" will cause confusion, I
> can use "Asuna", which is the name I used on IM chats and social media
> platforms.

A "unique" identifier that you use to identify yourself is fine,
"Sprite" is not really unique :)

thanks,

greg k-h
