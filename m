Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A7237F7670
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Nov 2023 15:38:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231200AbjKXOiM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Nov 2023 09:38:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229742AbjKXOiK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Nov 2023 09:38:10 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A91171718
        for <linux-kernel@vger.kernel.org>; Fri, 24 Nov 2023 06:38:17 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45AC1C433CB;
        Fri, 24 Nov 2023 14:38:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700836697;
        bh=OSsETKA6fwqSq8MTrXvGGiqnQ7ZWBL+ygcVW9Hzy7zQ=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=p8bl87mXD4NcH6cQYh+IHmtKEZkb9we+PyWjqON3vOtuUep33sn/bGqjFOesAW7Pd
         6h2rA9ChfqBGFdha6gFIdNzTqIk1xbJ45SgH4em1U+lcxfgNjE4pSfBJzsYaBNBfax
         NmJ8LXB08r2hHlBNABatUaDXhOf1WYP7UXau5fMGhLNCpXaUWfXwuIE/7r4sjwZb0w
         K9OyqiReidsOoVkcOc9LZThCB2PmJItXmKns5sdrHKx5lC9HI+YCGaxzBLn9eeRw52
         yZCwQuHVCEbpNu8NPpNkJPAU8bmazRkucMI+i/s4lxej6nju3dH1sh0oGznGOxoyab
         3QcVOCSwiFfzQ==
From:   Pratyush Yadav <pratyush@kernel.org>
To:     Tudor Ambarus <tudor.ambarus@linaro.org>
Cc:     pratyush@kernel.org, michael@walle.cc,
        linux-mtd@lists.infradead.org, linux-doc@vger.kernel.org,
        corbet@lwn.net, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] docs: mtd: spi-nor: drop obsolete info
In-Reply-To: <20231123160721.64561-3-tudor.ambarus@linaro.org> (Tudor
        Ambarus's message of "Thu, 23 Nov 2023 18:07:21 +0200")
References: <20231123160721.64561-1-tudor.ambarus@linaro.org>
        <20231123160721.64561-3-tudor.ambarus@linaro.org>
Date:   Fri, 24 Nov 2023 15:38:15 +0100
Message-ID: <mafs0o7fjdxns.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 23 2023, Tudor Ambarus wrote:

> The architecture description is obsolete, it no longer applies to
> the current SPI NOR framework state, remove it.
>
> Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>

Reviewed-by: Pratyush Yadav <pratyush@kernel.org>

-- 
Regards,
Pratyush Yadav
