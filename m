Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E967878A303
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Aug 2023 00:47:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229472AbjH0Wp5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Aug 2023 18:45:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbjH0Wpk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Aug 2023 18:45:40 -0400
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::224])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9094B12A;
        Sun, 27 Aug 2023 15:45:37 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 41EEEE0004;
        Sun, 27 Aug 2023 22:45:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1693176336;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=dozuiHFWVmwXy/XjSULVyK7tV7sAHAuCVEVPDVdbkrA=;
        b=egWOuQ7au4VP2cYnhvdtarFdFP1V5aHgAf3gFp2PQkqW7GOnV30IF1DqER7pyW0Zo+VB6u
        QTf1DUYjQgza9xq14na6rzrymnlciuUDBPYnFqkZYB3Ottqr8XPVSiSvMgdyRVdKrKsdZP
        JvELY00bVSI0TizzZ7sgFefgYKnc40ROWn9Jyo6PDBIdsOhkRdVhLol4C4Kgsp1df12SKZ
        FXaM6APUFPyLeNDbeAa79h0ufZZlAXQwGEF42DE5a+P49cmDuQ4nNWDZ8uJVt9hj1kgygA
        6+9SnHUyBrwEWvx/wZqMqsrwLolwh9kK0q4JxSlyVn0g/2GZdHlV2EpCAHudWA==
Date:   Mon, 28 Aug 2023 00:45:34 +0200
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Aniket <aniketmaurya@google.com>
Cc:     linux-i3c@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, joychakr@google.com,
        manugautam@google.com
Subject: Re: [PATCH] dt-bindings: i3c: Fix description for assigned-address
Message-ID: <169317630418.562439.4628786119246659411.b4-ty@bootlin.com>
References: <20230822051209.2837818-1-aniketmaurya@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230822051209.2837818-1-aniketmaurya@google.com>
X-GND-Sasl: alexandre.belloni@bootlin.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 22 Aug 2023 05:12:09 +0000, Aniket wrote:
> assigned-address is a valid property for I3C device with or without
> static address. Fix the description and an example for the same.
> 
> 

Applied, thanks!

[1/1] dt-bindings: i3c: Fix description for assigned-address
      commit: 32e6b31a6a80ba9493fad802d68d41f4d63230cc

Best regards,

-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
