Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C33F7C69C1
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 11:34:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235568AbjJLJeg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 05:34:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235507AbjJLJef (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 05:34:35 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 514FCBA;
        Thu, 12 Oct 2023 02:34:34 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5178C433C7;
        Thu, 12 Oct 2023 09:34:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697103274;
        bh=t6RQ+9sFHC3DagLE5Z/fys5Xd0OLHPhwljd2TyKmTtk=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=iSc2RD480jpmCIYt1o2dOFJTp0CLw4ZyIy4dYmcJO5wRoj1t2ei9JMnUB7hK/M+Yr
         pohGYlOmhYS+VNJUvnglgR009iXPKtOgeJddMMekcuF9FOFbpbJFzcRITqbns7ifeK
         OHuR5MeqV5jX8uaS7b+j5pA71Z8jgRBhghRPrZcSKNnwSyxKz8ix7DfWThnduO+U1k
         N9LiarGn7Kc/cE9yc6zVMBM+NCeoqYpywhjTcxAbXXWh83KbRi5TB6tHQf3BFkRcx3
         ce6WMCXBNMNL/3U1YUUKarVbVohE8ykuKUxzUGCrPYLZkPDqR0oTjpBmCogiezBgNa
         krOYV/CZW2wfQ==
From:   Lee Jones <lee@kernel.org>
To:     linux-kernel@vger.kernel.org,
        =?utf-8?q?Ond=C5=99ej_Jirman?= <megi@xff.cz>
Cc:     Pavel Machek <pavel@ucw.cz>, Lee Jones <lee@kernel.org>,
        linux-leds@vger.kernel.org
In-Reply-To: <20231008144014.1180334-1-megi@xff.cz>
References: <20231008144014.1180334-1-megi@xff.cz>
Subject: Re: [PATCH] leds: core: Add more colors from DT bindings to
 led_colors
Message-Id: <169710327259.1153136.5768257174962455662.b4-ty@kernel.org>
Date:   Thu, 12 Oct 2023 10:34:32 +0100
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

On Sun, 08 Oct 2023 16:40:13 +0200, Ondřej Jirman wrote:
> The colors are already part of DT bindings. Make sure the kernel is
> able to convert them to strings.
> 
> 

Applied, thanks!

[1/1] leds: core: Add more colors from DT bindings to led_colors
      commit: e2d508c7abbf0f8ff0d6467de07abf08c8fb5041

--
Lee Jones [李琼斯]

