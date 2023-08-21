Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C2BA782DDA
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Aug 2023 18:07:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235201AbjHUQHx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Aug 2023 12:07:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232366AbjHUQHv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Aug 2023 12:07:51 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0596E4;
        Mon, 21 Aug 2023 09:07:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 358B361600;
        Mon, 21 Aug 2023 16:07:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 092A5C433C8;
        Mon, 21 Aug 2023 16:07:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692634069;
        bh=aT4SGY9IPVc6jLbbastYJsDqzEAZ1PvzDO2DXs7jaSM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fWVBrmpoMqNKCOK8IiNqO5GVVyKuIvo+ILEn3wxNpgnQQFZQ/GNM1v07rY6vcWtgY
         fv2xG4IWUALYh/+4ziwLrsHKgmbKYFn+pdyH07kZ6ztl44/XhhldR+2umrHq7DXexg
         ROyJzpUDbY6CfUVTNSFrB0Mzv4vRfa52w2/P0d7IJkqSAQURej4tp592juw+JRC82q
         mUoqv9tIPYbyBzTEMKxQ9ruyRw5DyOAsg4X2fRdT0lmmJlCbOfDJRck5noLX63/oZa
         ipzzVYNEjMu+XozRmYJxgVdniZy8MagT7CgBvKiMIOtWjHl2W8c0cdnlzzMSY3AkzZ
         dO54B3FJL29IA==
Date:   Mon, 21 Aug 2023 18:07:45 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Shuah Khan <skhan@linuxfoundation.org>
Cc:     "Paul E. McKenney" <paulmck@kernel.org>, Willy Tarreau <w@1wt.eu>,
        Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas@t-8ch.de>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: duplicate patch in the nolibc tree
Message-ID: <20230821-raven-abreibung-cc4abe44c9f5@brauner>
References: <20230817133811.0a73c624@canb.auug.org.au>
 <e0af8d82-e099-49fa-9fbd-6f6bb63b7706@t-8ch.de>
 <9cfb4fe4-162b-3f26-646b-71bed3493925@linuxfoundation.org>
 <4c037ef2-9159-4528-8ecb-8596cb2a3889@paulmck-laptop>
 <20230817193909.GA30505@1wt.eu>
 <01d517c4-d91b-4426-b7f2-2b1277f21d8c@paulmck-laptop>
 <20230818-anblicken-mitinhaber-11cd07cce0a1@brauner>
 <e08e3dd5-48b8-5da2-5d0c-7d5b70a9e9be@linuxfoundation.org>
 <6822c914-4f11-be93-ed55-56447a5838f9@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <6822c914-4f11-be93-ed55-56447a5838f9@linuxfoundation.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> We will go to our plan b of having Willy drop the patch, resend the
> pull request to me ....

No, I didn't drop it so I appreciate it if you went with your plan.
If I drop it now I'd be causing churn after having this sit in -next for
over 5 weeks and I'll send a pr in the middle of this week.

Thanks!
