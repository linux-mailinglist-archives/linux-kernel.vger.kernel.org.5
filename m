Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FE6F75277F
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 17:42:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233609AbjGMPmD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 11:42:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbjGMPmB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 11:42:01 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABCCD2682;
        Thu, 13 Jul 2023 08:42:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 40C0461993;
        Thu, 13 Jul 2023 15:42:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11ADAC433C8;
        Thu, 13 Jul 2023 15:41:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689262919;
        bh=f7uSaM8HqDoMtq+Sp4ZbubCoj2iMR2/SgaP/2QzJxCc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VEfNf/xlW8ZmhIJIvKVCJCvbG/QMk3Gw0KqPagMlVi1zr/W3Y8M/zteVr3D08umt2
         RgRjQ43OolpY9jWWjQ/E5gE8J30GEOYP97cISWrefkZm3QSiFrMmAe2aTfKJHFPU5B
         WtUFZnACcqaqsTWSJ2pksYOMVzuOyC/UBxPD5485zlXgSawwOhdgAzNF+BtQMkeExN
         olvCc1gY3yFT4wsT4HCB3UfKy8oT3c6bFKSXpe8QHG4FRjjOE2mWpxgvLjWn7KXla5
         TTt3LcK0zAzwPM//FFhIZVs9wigEL/uacwD67bJ0sVgx3FYI/1NB754YbS4rQF3Nik
         4K6ayrtFqCqzg==
Date:   Thu, 13 Jul 2023 16:41:55 +0100
From:   Lee Jones <lee@kernel.org>
To:     Henning Schild <henning.schild@siemens.com>
Cc:     Pavel Machek <pavel@ucw.cz>, Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>, linux-leds@vger.kernel.org,
        linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org
Subject: Re: [PATCH 2/2] leds: simatic-ipc-leds-gpio: fix comment style in
 SPDX header
Message-ID: <20230713154155.GE968624@google.com>
References: <20230706161040.21152-1-henning.schild@siemens.com>
 <20230706161040.21152-3-henning.schild@siemens.com>
 <20230712115252.GA10768@google.com>
 <20230712141013.67140778@md1za8fc.ad001.siemens.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230712141013.67140778@md1za8fc.ad001.siemens.net>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 12 Jul 2023, Henning Schild wrote:

> Am Wed, 12 Jul 2023 12:52:52 +0100
> schrieb Lee Jones <lee@kernel.org>:
> 
> > On Thu, 06 Jul 2023, Henning Schild wrote:
> > 
> > > This was found with giving the file to checkpatch.
> > > 
> > > Signed-off-by: Henning Schild <henning.schild@siemens.com>
> > > ---
> > >  drivers/leds/simple/simatic-ipc-leds-gpio.h | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > 
> > > diff --git a/drivers/leds/simple/simatic-ipc-leds-gpio.h
> > > b/drivers/leds/simple/simatic-ipc-leds-gpio.h index
> > > bf258c32f83d..3d4877aa4e0c 100644 ---
> > > a/drivers/leds/simple/simatic-ipc-leds-gpio.h +++
> > > b/drivers/leds/simple/simatic-ipc-leds-gpio.h @@ -1,4 +1,4 @@
> > > -// SPDX-License-Identifier: GPL-2.0
> > > +/* SPDX-License-Identifier: GPL-2.0 */  
> > 
> > What prompted this change?
> > 
> > % git grep -F "// SPDX-License-Identifier:" -- drivers/leds | wc -l
> > 117
> > % git grep -F "/* SPDX-License-Identifier:" -- drivers/leds | wc -l
> > 2
> > 
> 
> ./scripts/checkpatch.pl --no-tree --file
> drivers/leds/simple/simatic-ipc-leds-gpio.h 
> 
> it boils down to header versus c-file, not sure why headers prefer that
> other style

Ah yes, that one.  Okay.

-- 
Lee Jones [李琼斯]
