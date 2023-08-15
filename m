Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2873D77D08B
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Aug 2023 19:06:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238616AbjHORFf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Aug 2023 13:05:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238660AbjHORFU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Aug 2023 13:05:20 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FB1E19BF
        for <linux-kernel@vger.kernel.org>; Tue, 15 Aug 2023 10:05:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8378F61A11
        for <linux-kernel@vger.kernel.org>; Tue, 15 Aug 2023 17:05:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C57CC433C8;
        Tue, 15 Aug 2023 17:05:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692119117;
        bh=ksBkkeKGbL5KD232ihdufsJpAFxLO+wHPzbvXFwqxr8=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=F0Dbvw/OFYyAEGdb/d7L4VQM902zvURQ9LH5LBYL9M8NeGocZKELE/BsxsF6kFWgC
         OlDgmGiqXbmmpsbvz8qLs2KgjPu8ywKshpc+Vr26rcpe4mwc23f3YXBviiHjwWQiAe
         dLj8qK3jtgv3+IiLq4ibm4J18jFtDrVxfw7SdnQ8uiMfNGxX4azFzFMds1EwEZVq2r
         Td8Qrrpwg2msIucnpNeZNmXz3CNusYfhvXS2g6/TXLItteW2tsoHL2Aynh+q81YMgU
         1VztshL8zEJUbbfXsM9FJ+We/kfXd+RYynaV09LTWX8EpxeaTvIGGuRpDBZxCFhf5X
         mkTf30ggOQgOg==
From:   Lee Jones <lee@kernel.org>
To:     lee@kernel.org, Yang Li <yang.lee@linux.alibaba.com>
Cc:     linux-kernel@vger.kernel.org
In-Reply-To: <20230810005938.12519-1-yang.lee@linux.alibaba.com>
References: <20230810005938.12519-1-yang.lee@linux.alibaba.com>
Subject: Re: (subset) [PATCH -next] mfd: Remove duplicated include in
 rz-mtu3.c
Message-Id: <169211911704.703287.9379789691588873700.b4-ty@kernel.org>
Date:   Tue, 15 Aug 2023 18:05:17 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.12.2
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 10 Aug 2023 08:59:38 +0800, Yang Li wrote:
> ./drivers/mfd/rz-mtu3.c: linux/module.h is included more than once.
> 
> 

Applied, thanks!

[1/1] mfd: Remove duplicated include in rz-mtu3.c
      commit: 956a2c4d00487fb47f8350957eb48bbc97978acf

--
Lee Jones [李琼斯]

