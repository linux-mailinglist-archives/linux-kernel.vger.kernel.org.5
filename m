Return-Path: <linux-kernel+bounces-79472-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BF1C38622B5
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 06:22:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BAF6D1C21B1B
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 05:22:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9020C168D2;
	Sat, 24 Feb 2024 05:22:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BGS3zr0D"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4CBB1FAA;
	Sat, 24 Feb 2024 05:22:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708752134; cv=none; b=QcfMG9OIwzHh4NYMiEZNakzWyY/hiWLefV4MiwrkEETZ2kJafSll8hqptFiyx2v1dF7SO2DXR38qJDhAltLkKtnksFaVtHM2Z5++OIUR15F2g3XbuHBaxrlJjqZ63we/LKv1/Ou1Z7e0lM6ftAFfWkgnFkaj6T/fpGC/J9Sue2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708752134; c=relaxed/simple;
	bh=HHtLlzJRzglu7AQ6pOsFiUQ6vA11VIbiU2QckkHsOCE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FltVOfvUj8Imhl9FD5uRox1niJiRDT2hfpnxoH+NhzzY6QiZC6gX4oSoPf/Xn90yDGux7n1pHgF0blYUPIjmDuVbwOJb2dfJ8VX4R2yg6RWifudVfFoDBHFjovdkMcfHgnYVuK1UQqy+sIdxp2ZLxKaCrH5bEMer+oV+Ehj0A/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BGS3zr0D; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4AF8BC433C7;
	Sat, 24 Feb 2024 05:22:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708752134;
	bh=HHtLlzJRzglu7AQ6pOsFiUQ6vA11VIbiU2QckkHsOCE=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=BGS3zr0Dc2B8CEcSjLJZWSAuMc7gjQc+c7Z6nUd6h8bEM/aYwFphEW6tNOjE9ykxv
	 9EUnESBKrjJNbFdlI7d57A8D85/zOYGu3mMMKNWJh10iTdmJ4F/G7UhwOCbAPAifPO
	 wr5TKwkNNlTW4johOgGw9xUrBzVjUkjunWXqHcdhRtyOVM+gBgc5fsUNtxio5WyWgX
	 rTtf80OwPZNxaPmXjUNNqqf5QIsEwxcGkviNe9NS3bvJiWuATLuhBLAZTNUxAobGlw
	 qqiVywhMfpqIv+Ar5f9YaYntvLaa1n2Re3ccW09mW7BV3uAB7ad9Rw1C3Jt6xKQai3
	 OLz67S7C02KrQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id E938ACE1113; Fri, 23 Feb 2024 21:22:13 -0800 (PST)
Date: Fri, 23 Feb 2024 21:22:13 -0800
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Joel Fernandes <joel@joelfernandes.org>
Cc: neeraj.upadhyay@kernel.org, frederic@kernel.org, boqun.feng@gmail.com,
	josh@joshtriplett.org, rcu@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] MAINTAINERS: Update Neeraj's email address
Message-ID: <1e44377c-70f6-484d-895c-7ad17439fa09@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20240224045730.29812-1-neeraj.upadhyay@kernel.org>
 <cfe9394d-8144-48d0-a8f1-de9fb54eabc5@joelfernandes.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cfe9394d-8144-48d0-a8f1-de9fb54eabc5@joelfernandes.org>

On Fri, Feb 23, 2024 at 11:58:58PM -0500, Joel Fernandes wrote:
> 
> 
> On 2/23/2024 11:57 PM, neeraj.upadhyay@kernel.org wrote:
> > From: Neeraj Upadhyay <neeraj.upadhyay@kernel.org>
> > 
> > Update my email-address in MAINTAINERS and .mailmap entries to my
> > kernel.org account.
> > 
> > Signed-off-by: Neeraj Upadhyay <neeraj.upadhyay@kernel.org>
> > ---
> >  .mailmap    | 3 ++-
> >  MAINTAINERS | 2 +-
> >  2 files changed, 3 insertions(+), 2 deletions(-)
> > 
> > diff --git a/.mailmap b/.mailmap
> > index 08f28f2999f0..dd6ea71c9271 100644
> > --- a/.mailmap
> > +++ b/.mailmap
> > @@ -441,7 +441,8 @@ Mythri P K <mythripk@ti.com>
> >  Nadia Yvette Chambers <nyc@holomorphy.com> William Lee Irwin III <wli@holomorphy.com>
> >  Naoya Horiguchi <naoya.horiguchi@nec.com> <n-horiguchi@ah.jp.nec.com>
> >  Nathan Chancellor <nathan@kernel.org> <natechancellor@gmail.com>
> > -Neeraj Upadhyay <quic_neeraju@quicinc.com> <neeraju@codeaurora.org>
> > +Neeraj Upadhyay <neeraj.upadhyay@kernel.org> <quic_neeraju@quicinc.com>
> > +Neeraj Upadhyay <neeraj.upadhyay@kernel.org> <neeraju@codeaurora.org>
> >  Neil Armstrong <neil.armstrong@linaro.org> <narmstrong@baylibre.com>
> >  Nguyen Anh Quynh <aquynh@gmail.com>
> >  Nicholas Piggin <npiggin@gmail.com> <npiggen@suse.de>
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index 189184ecdb11..1006a6973320 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -18461,7 +18461,7 @@ F:	tools/testing/selftests/resctrl/
> >  READ-COPY UPDATE (RCU)
> >  M:	"Paul E. McKenney" <paulmck@kernel.org>
> >  M:	Frederic Weisbecker <frederic@kernel.org> (kernel/rcu/tree_nocb.h)
> > -M:	Neeraj Upadhyay <quic_neeraju@quicinc.com> (kernel/rcu/tasks.h)
> > +M:	Neeraj Upadhyay <neeraj.upadhyay@kernel.org> (kernel/rcu/tasks.h)
> 
> Reviewed-by: Joel Fernandes <joel@joelfernandes.org>

I have pulled this in, thank you both!

If someone else wants to take it:

Reviewed-by: Paul E. McKenney <paulmck@kernel.org>

							Thanx, Paul

