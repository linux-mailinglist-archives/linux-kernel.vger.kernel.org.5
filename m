Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CD89754D3F
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Jul 2023 05:55:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229642AbjGPDzt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 Jul 2023 23:55:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbjGPDzq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Jul 2023 23:55:46 -0400
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E33941BF3
        for <linux-kernel@vger.kernel.org>; Sat, 15 Jul 2023 20:55:42 -0700 (PDT)
Received: from pecola.lan (unknown [159.196.93.152])
        by mail.codeconstruct.com.au (Postfix) with ESMTPSA id 8AE392013E;
        Sun, 16 Jul 2023 11:55:33 +0800 (AWST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=codeconstruct.com.au; s=2022a; t=1689479734;
        bh=HNi5zGFs1Mu5yAJOfpUV1Z2gds1fPf/ycyKdnw4VGiE=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References;
        b=hG7aQVCIaLg4J9pOkbZ7xLEj5NyZwvTsmwlzhjezf0o3pXGYgpgfTThlnFbOKMn9U
         Zh5tcLN04zBuQuYyG6jDxFor8EPD4SR0RNBjhl+TQo9rX0l05ALEn4ubHRAzTEVSmX
         ZhCV4OyFXpOhdCJf+t9WWV66TgjwlfzBh8YWjDOFfHNsQLnC6vsAxGwfMDoKAxHkwn
         x+71e+5pIYsiY3XCq0rpyAZBRlXbCRPL99vlPHB76gQ+C+GK6JKTI2Py1LUKap07IQ
         mdDsweIJTi6L40Yw1y6GgcHzZVptEPDkBoKi1qD7DR8foKU7TbjXrUXwPAO8bKmhuq
         BGMUOqN5Xhbiw==
Message-ID: <36c13d55cdb0a00bd4768b457987042cfc658349.camel@codeconstruct.com.au>
Subject: Re: [PATCH] i3c: Explicitly include correct DT includes
From:   Jeremy Kerr <jk@codeconstruct.com.au>
To:     Rob Herring <robh@kernel.org>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        =?UTF-8?Q?Przemys=C5=82aw?= Gaj <pgaj@cadence.com>
Cc:     devicetree@vger.kernel.org, linux-i3c@lists.infradead.org,
        linux-kernel@vger.kernel.org
Date:   Sun, 16 Jul 2023 11:55:33 +0800
In-Reply-To: <20230714174623.4057784-1-robh@kernel.org>
References: <20230714174623.4057784-1-robh@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4-2 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,

> In order to detangle these headers and replace the implicit includes
> with struct declarations

This refers to replacing the implicit includes within the of/ subsystem,
right?

> users need to explicitly include the correct includes.

LGTM, thanks!

Reviewed-by: Jeremy Kerr <jk@codeconstruct.com.au>

Cheers,


Jeremy
