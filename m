Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1030B7FB586
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 10:21:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234787AbjK1JVF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 04:21:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230298AbjK1JVE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 04:21:04 -0500
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE94EAB;
        Tue, 28 Nov 2023 01:21:08 -0800 (PST)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 940B06000E;
        Tue, 28 Nov 2023 09:21:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1701163267;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+AHfL8OlK5Wws5aBHfXQszsiM7vcGe9qGfq3zPeCIPk=;
        b=b1Ixi4AZJSKM3Hx5tZCcYnSm7Ixnt3mfB0C74X85YbM2kyyjJ3JtUqkEXYfvZ520BiYW47
        ccNtbgp/SdfNGOYYQYKRn8qoZvth9rggVjj8Tn1DoVFJaBb5cFVzqzYNcHHUF2lvNI5vPY
        shBwufx+v81gJuze7HFAYmHz/OFK+ZwOa4XC7KGSeIrXy78910kQE6sK/Whn9DbSk3XG6T
        X6D8CexFn6weqq27rfhqVRuHy2VYwAiu3Q1PkUF0tmnA7dTPFJlFK1KYI/eytNvXS+yfw6
        KJuwFHG8FJXnzM7yGY53qcqztktUrH8va16YvBXtftbMszgySgfa5HYWaN0bRA==
Date:   Tue, 28 Nov 2023 10:21:05 +0100
From:   Luca Ceresoli <luca.ceresoli@bootlin.com>
To:     Rob Herring <robh@kernel.org>
Cc:     linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Jeff LaBundy <jeff@labundy.com>, devicetree@vger.kernel.org,
        Conor Dooley <conor+dt@kernel.org>
Subject: Re: [PATCH v2] dt-bindings: input: touchscreen: goodix: clarify
 irq-gpios misleading text
Message-ID: <20231128102105.4d901b3a@booty>
In-Reply-To: <169565910910.1468857.379234431707593994.robh@kernel.org>
References: <20230925032208.11698-1-luca.ceresoli@bootlin.com>
        <169565910910.1468857.379234431707593994.robh@kernel.org>
Organization: Bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-GND-Sasl: luca.ceresoli@bootlin.com
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Rob,

On Mon, 25 Sep 2023 11:25:09 -0500
Rob Herring <robh@kernel.org> wrote:

> Acked-by: Rob Herring <robh@kernel.org>

I can't find this patch in your for-next, is there any blocker I should
handle?

Luca

-- 
Luca Ceresoli, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
