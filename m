Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2AEEB7F63BC
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 17:16:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229731AbjKWQPu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Nov 2023 11:15:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345095AbjKWQPs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Nov 2023 11:15:48 -0500
Received: from mail.3ffe.de (0001.3ffe.de [IPv6:2a01:4f8:c0c:9d57::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E7AA83;
        Thu, 23 Nov 2023 08:15:53 -0800 (PST)
Received: from 3ffe.de (0001.3ffe.de [IPv6:2a01:4f8:c0c:9d57::1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.3ffe.de (Postfix) with ESMTPSA id 79A3C33C;
        Thu, 23 Nov 2023 17:15:51 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2022082101;
        t=1700756151;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3mKxwmjen41Ks2QpqmtZQa7d9qvwTznyPnsUUWAHpOg=;
        b=wqByrB3M51mgwtA9Ou51bwSQ1rOjoonS140m3LdB2kZkTiFC8mcZmoMBdFQFbf7qM8XjcI
        JejDDfDG8kmJPoK5c2qzro2A5ihcgeyz9sYxanMSrdE9Mybxy0S/oH7akUhqibOmmvPRZf
        gUp/AOkHH0oYkSM47UPKEbq4004yAEvKZfIOsV4c2D7opK9JdCCDBtAmEWD/2ncxqAIMkW
        LCiOjLt3tXYwLBqIbBLzwaxuVbvaOqWNnnUzaJAjhLMWGKEoRH4ub9vz+FpdJqE4caxtVV
        +h//ZH1Lz4quO70pmmARZFa7EH8GevDTJBHLDoEY+gGJxEWkB7IShNmKKrO0ag==
MIME-Version: 1.0
Date:   Thu, 23 Nov 2023 17:15:51 +0100
From:   Michael Walle <michael@walle.cc>
To:     Tudor Ambarus <tudor.ambarus@linaro.org>
Cc:     pratyush@kernel.org, linux-mtd@lists.infradead.org,
        linux-doc@vger.kernel.org, corbet@lwn.net,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] docs: mtd: spi-nor: drop obsolete info
In-Reply-To: <20231123160721.64561-3-tudor.ambarus@linaro.org>
References: <20231123160721.64561-1-tudor.ambarus@linaro.org>
 <20231123160721.64561-3-tudor.ambarus@linaro.org>
Message-ID: <ea3aeb73f087bdd9719fb88aafda7ad1@walle.cc>
X-Sender: michael@walle.cc
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> The architecture description is obsolete, it no longer applies to
> the current SPI NOR framework state, remove it.
> 
> Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>

Reviewed-by: Michael Walle <michael@walle.cc>
