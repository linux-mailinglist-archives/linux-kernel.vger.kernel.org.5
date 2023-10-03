Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C7997B63FF
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 10:24:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239597AbjJCIYK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 04:24:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239956AbjJCIX6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 04:23:58 -0400
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::225])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB01FB4;
        Tue,  3 Oct 2023 01:23:24 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 2D8551C0007;
        Tue,  3 Oct 2023 08:23:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1696321403;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jSGcSwAqUefKWmuimG5WT5sO8MU51Z7G0dHxsNTfhXM=;
        b=J8fnA1o8wn6xc0cQOA4aHjVfrhDtatLI15AwEqfkCmRZNmwQ+SHktd6U38GrZplOOvBKpH
        fD+SKVGxi/4rLFf/e/ygsfGdY5r5+ydbBux0xZ8mdWK9PGWMeQzi3ufBKF6+iaZFr2juwf
        aFU1xDdhouV1o6Ijw+N4gHhnr5aDP00flyo40GH778kB5EpZCnryuajnGo+LXYyrE6EVk5
        /keLPFJcVPRpQy+gnlc/KKYbSGddlJBTexnXDhX8tPBbM/qQGpIFapuAIdRwxObCbSdMqP
        GVYJbYQFlLV72qnt3FVo1nHt0CmDIBEM7lAmYs5W9Dndp4bEe11Nsd0IJA3CMw==
Date:   Tue, 3 Oct 2023 10:23:19 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Matt Johnston <matt@codeconstruct.com.au>
Cc:     linux-i3c@lists.infradead.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Conor Culhane <conor.culhane@silvaco.com>,
        linux-kernel@vger.kernel.org (open list),
        devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED
        DEVICE TREE BINDINGS),
        linux-doc@vger.kernel.org (open list:DOCUMENTATION)
Subject: Re: [PATCH] i3c: Fix typo "Provisional ID" to "Provisioned ID"
Message-ID: <20231003102319.77fdf512@xps-13>
In-Reply-To: <20231003075339.197099-1-matt@codeconstruct.com.au>
References: <20231003075339.197099-1-matt@codeconstruct.com.au>
Organization: Bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-GND-Sasl: miquel.raynal@bootlin.com
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Matt,

matt@codeconstruct.com.au wrote on Tue,  3 Oct 2023 15:53:39 +0800:

> The MIPI I3C spec refers to a Provisioned ID, since it is (sometimes)
> provisioned at device manufacturing.
>=20
> Signed-off-by: Matt Johnston <matt@codeconstruct.com.au>

Reviewed-by: Miquel Raynal <miquel.raynal@bootlin.com>

Thanks,
Miqu=C3=A8l
