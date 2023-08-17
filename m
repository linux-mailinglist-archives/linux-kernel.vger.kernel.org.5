Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53B0A77F77E
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Aug 2023 15:16:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351329AbjHQNPa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 09:15:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351377AbjHQNPE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 09:15:04 -0400
Received: from mail.3ffe.de (0001.3ffe.de [159.69.201.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFF3E2D7E
        for <linux-kernel@vger.kernel.org>; Thu, 17 Aug 2023 06:15:01 -0700 (PDT)
Received: from 3ffe.de (0001.3ffe.de [IPv6:2a01:4f8:c0c:9d57::1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.3ffe.de (Postfix) with ESMTPSA id 6CF1B3D9;
        Thu, 17 Aug 2023 15:14:59 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2022082101;
        t=1692278099;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=smIG5hi/qQQO7zsEVLHIIK2UNrg451bmx1kSE8izq6Y=;
        b=vMbCq8i0GOclICjBdWlA/1LUt9oHo/9Ar1S8G9Lfo2W6y1NeYnL56AfRHLYTtxUQkbyyT+
        jZcRK/odQ98uX4PrIUr/tdGhnT0lsyqAlU2Fffj6rmX7b9Yj8Mdk5q4rgWdldT4dXh8Asf
        jwyKS2BaMXYhY7xaOqrtm7aAun0IOiqp0BxGDBoDJkmguviUi+dxW6JjlMTuHpLnBC2p1X
        JkA0YaX7jywsD2K7Rb3BJV8GyHQqCm3xoQG6oT//dtK+pK/bqw085S5nTgG6+AjWqLQhTc
        sPj+fB0ZbadnI9cxOIBbl5yHCfpqy8FaAmDTlUsiInXmSwAbU2188XRZERzTfw==
MIME-Version: 1.0
Date:   Thu, 17 Aug 2023 15:14:59 +0200
From:   Michael Walle <michael@walle.cc>
To:     SSunk <ssunkkan@gmail.com>
Cc:     tudor.ambarus@linaro.org, pratyush@kernel.org,
        miquel.raynal@bootlin.com, richard@nod.at, vigneshr@ti.com,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        SSunk <ssunkkan@gmail.com>
Subject: Re: [PATCH] Add support for more XMC series
In-Reply-To: <20230817124655.13023-1-ssunkkan@gmail.com>
References: <20230817124655.13023-1-ssunkkan@gmail.com>
Message-ID: <8bbfdeecc4085e4f7c916c26c98de147@walle.cc>
X-Sender: michael@walle.cc
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

> Add XMC XM25QH128C/XM25QH256C/XM25QU256C/XM25QH512C/XM25QU512C
> and set the parse_sfdp flag.
> 
> Signed-off-by: Kankan Sun <ssunkkan@gmail.com>

NAK. You're just posting the same patch over and over again.

Please respond the the former questions and please read
https://www.kernel.org/doc/html/latest/process/submitting-patches.html

-michael
