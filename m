Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA39A79F215
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 21:32:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232399AbjIMTcp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 15:32:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231311AbjIMTcn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 15:32:43 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E51CB19A0;
        Wed, 13 Sep 2023 12:32:39 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4746C433CA;
        Wed, 13 Sep 2023 19:32:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694633559;
        bh=OKn/TXOCKGv7Oger77fIeEPQpwvtjRlLlhcR6bU/Qnk=;
        h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
        b=fLMqMlodDF8brxZ7XJlq/KeC/wL79vXN63y76WjL13KpQ6HdHkwV9Pe0k1QDtx7DK
         zKQalbtQbtqDnfSWiwNQsyObGB3k5Flbo1p1L6ChgGGsY5PlbPceMmT6ITwfAqjuTS
         FH5QwZwYmnpRvGjuUdt1nW9EZZCT0kKZnLLGyxdWf9CGKxjOrU6dyTfBJKn6Q0m3qG
         synvKNePx+UIKabiVWMh5JoqJolFBd+GWDVpKgPgJ3XjgxIf5Qsywe3KkWKuHUm4JF
         MDL3JZWHkdyfWPQvpCoeMjvH9EEv3aFSgOnvOiWqd2GUiREWl/gEQx7Rv4FAYf6uFb
         gKlxuZgUnQixg==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Wed, 13 Sep 2023 22:32:36 +0300
Message-Id: <CVI1GKA044I2.2A5GRO80ABMNN@suppilovahvero>
Cc:     "Peter Huewe" <peterhuewe@gmx.de>,
        "Jason Gunthorpe" <jgg@ziepe.ca>,
        "David Howells" <dhowells@redhat.com>,
        "Mimi Zohar" <zohar@linux.ibm.com>,
        "Justin M . Forbes" <jforbes@fedoraproject.org>,
        <linux-integrity@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <keyrings@vger.kernel.org>
Subject: Re: [GIT PULL] tpmdd changes for v6.6-rc2
From:   "Jarkko Sakkinen" <jarkko@kernel.org>
To:     "Linus Torvalds" <torvalds@linux-foundation.org>
X-Mailer: aerc 0.14.0
References: <20230912201102.1012306-1-jarkko@kernel.org>
 <CAHk-=wgLB9_z5TcvRKVsSk3BWPfkDeWN0pDMdEv=-hnrnTgX1Q@mail.gmail.com>
In-Reply-To: <CAHk-=wgLB9_z5TcvRKVsSk3BWPfkDeWN0pDMdEv=-hnrnTgX1Q@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed Sep 13, 2023 at 9:51 PM EEST, Linus Torvalds wrote:
> On Tue, 12 Sept 2023 at 13:11, Jarkko Sakkinen <jarkko@kernel.org> wrote:
> >
> > This pull request contains a critical fix for my previous pull request.
>
> Please, less sarcasm and more actual helpful merge commit fodder, ok?
>
>               Linus

Ok, I'll make something more reasonable.

BR, Jarkko
