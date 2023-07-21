Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1F4175D0BC
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 19:39:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229737AbjGURjw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jul 2023 13:39:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229477AbjGURju (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jul 2023 13:39:50 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF7CD30D0
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jul 2023 10:39:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4D37F61D68
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jul 2023 17:39:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF8E5C433C7;
        Fri, 21 Jul 2023 17:39:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689961188;
        bh=Lu+lThu4uKJv2G55IYuDpWtO5Bx+ozp9Lhj2x/GKyrk=;
        h=Date:From:To:Cc:Subject:Reply-To:From;
        b=vQEn/cMO0paaJuV+lPDh/qo79ovaaJcFUVXs5mR2CWpYdjKvgur8qAipAXVzWV8DP
         1K6kOg+0HTfgNwoZ3K8yTY5io0FgsPGSY5bHllFD02UkkJMGP5awCalOCiAhECecjx
         FQXf6bxUsEIDGEcFBais2djdT9827v5G/4j9XDfavnpw9PrfoMDsCv1Bg3GJ0tf+52
         10iWkn4xH71po5+IZ43Kyj9VlrFurx3wLb5C0Y6uV+4vgDhRwQsMuYrH1AG1XjIRAt
         4n95HF4oJDt92LzDec+NnXUFkp4K640+B5RYm6g2QoXS342qpPGFWfYCAewJVTwkRH
         Q6RwHKDzZRYPg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 41726CE092F; Fri, 21 Jul 2023 10:39:48 -0700 (PDT)
Date:   Fri, 21 Jul 2023 10:39:48 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Willy Tarreau <w@1wt.eu>, Shuah Khan <skhan@linuxfoundation.org>,
        Thomas =?iso-8859-1?Q?Wei=DFschuh?= <thomas@t-8ch.de>,
        linux-kernel@vger.kernel.org
Subject: Upcoming nolibc pull request for the next merge window
Message-ID: <7afafb6c-9664-44a1-bc8f-d20239db1dd5@paulmck-laptop>
Reply-To: paulmck@kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, Linus!

This is just to let you know that Willy and I are adding co-maintainers
for nolibc.  Shuah Khan will join me as administrative maintainer,
and will be sending the pull request to you for the next merge window.

Similarly, Thomas Weiﬂschuh will be joining Willy as technical maintainer
for nolibc.  With luck, this won't affect you, but in case you come across
a nolibc issue, please reach out to Thomas as well as Willy, Shuah,
and myself.  There will of course be an update to the MAINTAINERS file
in the near future, but just to let you know in the meantime.

							Thanx, Paul
