Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6EEA7CF3E1
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 11:18:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345039AbjJSJSh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 05:18:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229830AbjJSJSf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 05:18:35 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47C97A3;
        Thu, 19 Oct 2023 02:18:34 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 575FCC433C7;
        Thu, 19 Oct 2023 09:18:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697707113;
        bh=+jRQYiZmWjmg+Ein5ROKbm4COq8vpFQB7NVE2U5e3W4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=j0qtC5d5JyG0KR1ZLfPDM8Q+Ll173YHe4qZEXwikLkLU9fwvJcq4Zuh0FDCpsZ94q
         xklnP5285dUOIxOs3Zuz1gXnnJ5lSfxD/dRUlCCjJDAZj2Z7auOvK72mn+lBFKhV3z
         8eEmfqE5qdWUnQa9XeOKGnAC6OHmJk6s20+QtsG4mFGe/wRMRBazn2Jc6vi93LlL4F
         Re2N4kyAQ0bhYJVrD7CfmBhoysxtmWX5eo1nthQGeOemp0Hpn+Zke+98GA1YtEcFmu
         U7kJjyG229f2C+C5iDVpwnev2JjcVAwSA+Nbt04scaAsiUEvyh8ZTPkwgOZYoYo+j8
         rkvOYz2P3G8ng==
Date:   Thu, 19 Oct 2023 11:18:29 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: duplicate patches in the vfs-brauner tree
Message-ID: <20231019-verpfiffen-geste-f7c14c77e019@brauner>
References: <20231019101231.174f1124@canb.auug.org.au>
 <CAOQ4uxh8ydr+YdyKtD9yR1_kpkqkt+MdjvAzkA48F2UNSxz40w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAOQ4uxh8ydr+YdyKtD9yR1_kpkqkt+MdjvAzkA48F2UNSxz40w@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Maybe it would be easier to rebase vfs.misc over vfs.mount.write?

So I've now rebased vfs.misc onto vfs.mount.write.
Thanks for the report.
