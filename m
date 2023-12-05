Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD7C38051EA
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 12:19:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376988AbjLELTO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 06:19:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345052AbjLELTN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 06:19:13 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B2FC9A
        for <linux-kernel@vger.kernel.org>; Tue,  5 Dec 2023 03:19:20 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7ADA7C433C7;
        Tue,  5 Dec 2023 11:19:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701775159;
        bh=HngDu/p59rjdS/91Op5BdJMB1YFj7ZFV64bQJ7lv26I=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WXTy5Kqk8hzIuq16V6wBk7inNMvLwLJV2YnB2e50QBI+9TgHlCVOkaL0Jsl8Mj6sZ
         mol8h7uIknWFDEVrS9lcbtbOYh7pXd+U6iPWYCnBpglzl/nMZ6QvJfzR9DY2q65BBq
         xmIXhUYpkWr1M19cWvTlZjAYcnyZDekvxg/owuRuOA0sj86GxZTyZMeISiwYAb+bii
         T3oj51aeaoqtXbzyERhyN4LlDHv1axOSDy8qG7epqhYmgT6tE/ETusBtrk4kTdJa0p
         FRkCz9tf3ubTxy1GKPyQO/knm7WoNAyWy9SCWJKy9eSAzXhWwVEin3hgchZO5kXg0+
         BoEk1jTW/X8Og==
Date:   Tue, 5 Dec 2023 12:19:15 +0100
From:   Christian Brauner <brauner@kernel.org>
To:     Lukas Schauer <lukas@schauer.dev>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: Signed-off-by missing for commit in the vfs-brauner
 tree
Message-ID: <20231205-subjekt-lapidar-24f945980970@brauner>
References: <20231204090139.03f0ddcc@canb.auug.org.au>
 <5b43d427-f24e-4625-95eb-87ef21452025@schauer.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <5b43d427-f24e-4625-95eb-87ef21452025@schauer.dev>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 03, 2023 at 11:40:41PM +0100, Lukas Schauer wrote:
> Hey there,
> 
> I'm not sure on how to proceed here since I've never submitted patches to
> the kernel.
> Does this require additional input by me?

Nothing needed from you. I've fixed this up now.
