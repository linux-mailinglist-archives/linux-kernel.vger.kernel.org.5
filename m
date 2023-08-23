Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2047785276
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Aug 2023 10:13:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233951AbjHWIN1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Aug 2023 04:13:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233792AbjHWIJj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Aug 2023 04:09:39 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F29D10D9;
        Wed, 23 Aug 2023 01:08:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2DEBA6465C;
        Wed, 23 Aug 2023 08:08:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6DB9DC433C7;
        Wed, 23 Aug 2023 08:08:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692778125;
        bh=94WbXXcZulI55mtkDioX4pIQV1zZEAijr4XcDfOiOtk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hWOYkozfgRP+XDg/DLUtp+AUe8BIhx3J2b3emJvp/2j8udHctEG2cffkvMqnP1Ccs
         FjLjkEoO7ACET0pJ2l5jm6dJNTtLjf6N3vWotCpxt0a3L1YMnTyf0rWMv/gWW+2EF5
         bl/KgRLOHWRHwouCmi3cMhpdmL0CU0vRRItIgN8ebZWAfW1DQOJKkjzaG6qE5d8NOk
         elOO6cMFG68znLF1cnSxQZJyf61SC3Af0xStWNzTVI38mCmKFr+zlTacQQD7qpFuOY
         Pyccohqyau0YZILF0GPo8N8+pQY62p/iP3JWIqOGsk3AKCoLK4KeoBOx5PonajsHZV
         IocXOq2rtgW/A==
Received: from johan by theta with local (Exim 4.96)
        (envelope-from <johan@kernel.org>)
        id 1qYiuv-000ArQ-01;
        Wed, 23 Aug 2023 10:08:41 +0200
Date:   Wed, 23 Aug 2023 10:08:40 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Slark Xiao <slark_xiao@163.com>
Cc:     gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] USB: serial: option: add FOXCONN T99W368/T99W373
 product
Message-ID: <ZOW-iGcVpuWp_0y-@hovoldconsulting.com>
References: <20230823075751.4437-1-slark_xiao@163.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230823075751.4437-1-slark_xiao@163.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 23, 2023 at 03:57:51PM +0800, Slark Xiao wrote:
> The difference of T99W368 and T99W373 is the chip solution.
> T99W368 is designed based on Qualcomm SDX65 and T99W373 is SDX62.

> Signed-off-by: Slark Xiao <slark_xiao@163.com>
> ---
> v2: Remove defines of Foxconn vendor and product name.

Thanks for the update. Now applied.

Johan
