Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62459777534
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 11:59:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235124AbjHJJ7z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 05:59:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235090AbjHJJ7S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 05:59:18 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56F9E90;
        Thu, 10 Aug 2023 02:59:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E1D31656B3;
        Thu, 10 Aug 2023 09:59:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 395A1C433C9;
        Thu, 10 Aug 2023 09:59:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691661557;
        bh=irAw8C1RbIzipfSt1MnqWhrjlxxoQRCkAeMq+VcRA7Q=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=aYS9XZ2gch8tOZFweR+abCikrsOTVWRnN3vXDIbjcrUfrDUWu96X3Eev55KVFElOY
         7kajLAH9n+49UZj2rxzfpHxngpCglRAWIx1j40PAF4HRI36aYeapTKiq5pbKvk5UVi
         mintMg9N1d+7ODhGW1WpIdTw8lL8Z5tXY58vIbac6YWgh35WZL5O26D29I8cz5+9V4
         i7aqSBpi8nF6Xtj0xjpAUEiVVGlPzX2HMg3Rhp8E1yHiShqJk3sxjidgxQH4ckRLAq
         aLonGSxc7+fch0bMq8UBUq990+t+gCGpSRXQmd0c8djyr7NNKXm6OqyQvIjOTItWho
         c79/k6XLLFc8A==
Date:   Thu, 10 Aug 2023 11:59:11 +0200
From:   Simon Horman <horms@kernel.org>
To:     Jiri Pirko <jiri@resnulli.us>
Cc:     Claudiu Beznea <claudiu.beznea@tuxon.dev>,
        nicolas.ferre@microchip.com, conor.dooley@microchip.com,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, lgirdwood@gmail.com, broonie@kernel.org,
        perex@perex.cz, tiwai@suse.com, maz@kernel.org,
        srinivas.kandagatla@linaro.org, thierry.reding@gmail.com,
        u.kleine-koenig@pengutronix.de, sre@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org,
        linux-pwm@vger.kernel.org, alsa-devel@alsa-project.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] MAINTAINERS: update Claudiu Beznea's email address
Message-ID: <ZNS0708cDAt7H7ul@vergenet.net>
References: <20230804050007.235799-1-claudiu.beznea@tuxon.dev>
 <ZM0Be8S8zII8wV4l@nanopsycho>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZM0Be8S8zII8wV4l@nanopsycho>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 04, 2023 at 03:47:39PM +0200, Jiri Pirko wrote:
> Fri, Aug 04, 2023 at 07:00:07AM CEST, claudiu.beznea@tuxon.dev wrote:
> >Update MAINTAINERS entries with a valid email address as the Microchip
> >one is no longer valid.
> >
> >Acked-by: Conor Dooley <conor.dooley@microchip.com>
> >Acked-by: Nicolas Ferre <nicolas.ferre@microchip.com>
> >Signed-off-by: Claudiu Beznea <claudiu.beznea@tuxon.dev>
> >---
> >
> >Changes in v2:
> >- collected tags
> >- extended the recipients list to include individual subsystem
> >  maintainers and lists instead using only linux-kernel@vger.kernel.org
> >  as suggested initially by get_maintainers.pl
> 
> Consider adding entry in .mailmap as well please.

Hi Claudiu,

I'd like to echo Jiri's suggestion of adding .mailmap entry
to reflect this change.
