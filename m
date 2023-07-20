Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCBBC75B815
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 21:35:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230429AbjGTTfT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 15:35:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229609AbjGTTfS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 15:35:18 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD25E273F
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jul 2023 12:35:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 361B761B39
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jul 2023 19:35:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3DD2CC433C8;
        Thu, 20 Jul 2023 19:35:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689881705;
        bh=dV9aGsXWCvr0Ac1gshnAaVzWiwaXSmq1UCHY/ZsafDU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=TMdPxkt2qkTUISJFM+X00lqNiMotzP0z1OGsqUCxL7vCq3rpoCcgLzJfjoLlNkwN3
         uFyeORVJl40oGECGsUzESdBl50OlX54zHuAP0Ewc1R517WDA5cIKBahBcjjjqd2HZ6
         cfefFydlg7dQ/kKCqQ70qVG1yG04EQZx123ksWmg=
Date:   Thu, 20 Jul 2023 21:34:58 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Tree Davies <tdavies@darkphysics.net>
Cc:     philipp.g.hortmann@gmail.com, anjan@momi.ca, error27@gmail.com,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 01/12] Staging: rtl8192e: Rename function ActivateBAEntry
Message-ID: <2023072027-goliath-roaming-b06a@gregkh>
References: <ZK82TTDh4mthB/Hx@basil>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZK82TTDh4mthB/Hx@basil>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 12, 2023 at 04:25:01PM -0700, Tree Davies wrote:
> Rename function ActivateBAEntry to activate_ba_entry
> in order to Fix checkpatch warning: Avoid CamelCase
> 
> Signed-off-by: Tree Davies <tdavies@darkphysics.net>
> ---
>  drivers/staging/rtl8192e/rtl819x_BAProc.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)

Odd, this series is not correctly linked together (see lore.kernel.org
for the results), and it's not listed as a v2?

Please fix this up and resend the whole series properly.

thanks,

greg k-h
