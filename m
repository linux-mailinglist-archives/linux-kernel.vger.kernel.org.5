Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E262575F8BC
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 15:46:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229926AbjGXNmg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 09:42:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230051AbjGXNmY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 09:42:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1A4146A0;
        Mon, 24 Jul 2023 06:40:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 800AF6119D;
        Mon, 24 Jul 2023 13:40:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 302F9C433C8;
        Mon, 24 Jul 2023 13:40:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690206023;
        bh=7VK9jJWcA5IF2fw7CTNRyBS01jbdJZKP1SvMiFae2tY=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=ipXG9ZK6MEpe+Lx1Ffj8F10deqNdAGPgNvgJ2CSjgit5K5GpmGsHzREHTtZqsfG3Y
         LF5nuFopIJwhx7lCsWUCreMIWWN4xE394f+mGMl+J5+ATt8nTpzwAoF4p/w8kjEN3B
         CYwj/v9/WoAlTrhUnlZdwLL9EFXiVayYYiwBV9wsIrB430S4MHdapMwJFV8DweNdni
         52uuwuAqDusHTILYWd13b51q0sFE0MOYI0cqAInUVyA6HbJ0WPmc8AZo/DYNoDLDi9
         zYYWno1p/9P+qd0ipXEBI09CvOqPCh3HTgQGYLO+0asEFRmwg9PEzmZgUkalQFmg2T
         v9X5PncS/8eiQ==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: MAINTAINERS: Update mwifiex maintainer list
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20230721160603.1.Idf0e8025f59c62d73c08960638249b58cf215acc@changeid>
References: <20230721160603.1.Idf0e8025f59c62d73c08960638249b58cf215acc@changeid>
To:     Brian Norris <briannorris@chromium.org>
Cc:     linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
        Brian Norris <briannorris@chromium.org>,
        Amitkumar Karwar <amitkarwar@gmail.com>,
        Ganapathi Bhat <ganapathi017@gmail.com>,
        Sharvari Harisangam <sharvari.harisangam@nxp.com>,
        Xinming Hu <huxinming820@gmail.com>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <169020602002.3064516.16937923273449843134.kvalo@kernel.org>
Date:   Mon, 24 Jul 2023 13:40:21 +0000 (UTC)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Brian Norris <briannorris@chromium.org> wrote:

> We haven't heard anything from these folks in years. I've been reviewing
> many submissions and plan to keep doing so.
> 
> Cc: Amitkumar Karwar <amitkarwar@gmail.com>
> Cc: Ganapathi Bhat <ganapathi017@gmail.com>
> Cc: Sharvari Harisangam <sharvari.harisangam@nxp.com>
> Cc: Xinming Hu <huxinming820@gmail.com>
> Signed-off-by: Brian Norris <briannorris@chromium.org>

Patch applied to wireless.git, thanks.

a2777be03236 MAINTAINERS: Update mwifiex maintainer list

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20230721160603.1.Idf0e8025f59c62d73c08960638249b58cf215acc@changeid/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

