Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4EB7576327D
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 11:40:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232921AbjGZJkP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 05:40:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230391AbjGZJkN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 05:40:13 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABC7DB6
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 02:40:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4083161A1D
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 09:40:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C9A5C433C8;
        Wed, 26 Jul 2023 09:40:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1690364411;
        bh=D8yfITNXs6RusFkc2ftQUSOtM66kPX8jC5G5AUoMRxE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nixIMp9XNSKAgRtpfgznHXGL5fQkBTeEnqvBCnMRSzWTWc8FrBSmvPVDoSN1NJhPk
         Gfhtp4svyLAaj0nWOeQfi70YHZas0656MBgZk2H9gYqlybr0MY07YfaU/lXOud29p6
         R5NTOAQdLSahhhcgU8K1VMeCZxoYq4dmGngUbT/c=
Date:   Wed, 26 Jul 2023 11:40:08 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     oushixiong <oushixiong@kylinos.cn>
Cc:     Jiri Slaby <jirislaby@kernel.org>,
        Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Samuel Thibault <samuel.thibault@ens-lyon.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] tty: vt: Fix spelling typo in comment
Message-ID: <2023072654-decidable-chrome-ed51@gregkh>
References: <20230726091044.705393-1-oushixiong@kylinos.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230726091044.705393-1-oushixiong@kylinos.cn>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 26, 2023 at 05:10:43PM +0800, oushixiong wrote:
> Signed-off-by: oushixiong <oushixiong@kylinos.cn>
> ---
>  drivers/tty/vt/vt.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

For obvious reasons, I can't take patches without any changelog comments
:(

