Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9D5B7E5F7A
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Nov 2023 21:50:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231881AbjKHUup (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Nov 2023 15:50:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229506AbjKHUun (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Nov 2023 15:50:43 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C36F61FFA
        for <linux-kernel@vger.kernel.org>; Wed,  8 Nov 2023 12:50:41 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C2FBC433C7;
        Wed,  8 Nov 2023 20:50:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699476641;
        bh=Uelb5NqzbNEI8JHBq/JEHRinkFc436EpDrK/QpervBk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LC5KrxqXq7wg8Fj/wobOL+FxhDDXZBk40qTZq3I4E2DMTPCjFrnJgpDJ3f7BNIwYT
         ECsz/29pIXsCQxEWlcPWXp/CFb5d+dTbBuyT9jXw6y7/k4G/7SCIdOjZhQJQKppC4d
         TtHFTaTSgkWUSZtWJ9OQHjLoRdjgXf1jMbUdQHqLfCtD78hXMeI4p2384fLsOHxfIG
         TfADaio/zYVIJV5GIkBHATgqBbgzw4z4mKMQeFQwkymPnLQlLWozZjmGO3dMXWVjEZ
         BdlGBF8RRgknahAjOm6Cvxnz7rcFIKq0VR3C7EhLWWsHhn7K7jjeLOuDw3LjFloajb
         EmsFg3DX3CT5A==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id E69F640094; Wed,  8 Nov 2023 17:50:38 -0300 (-03)
Date:   Wed, 8 Nov 2023 17:50:38 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     James Clark <james.clark@arm.com>
Cc:     Ian Rogers <irogers@google.com>, linux-perf-users@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Yang Jihong <yangjihong1@huawei.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev
Subject: Re: [PATCH] perf test: Add option to change objdump binary
Message-ID: <ZUv0nsO19pFs0lXS@kernel.org>
References: <20231103113501.490012-1-james.clark@arm.com>
 <CAP-5=fWazX_q1W8HN7ErrRMB2bx5sz3x1V=+XqY7Hxx0jR0p9w@mail.gmail.com>
 <47e3d265-e48e-238f-7528-b0eb4c250cb1@arm.com>
 <ZUv0NKS7d4vYQMxy@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZUv0NKS7d4vYQMxy@kernel.org>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, Nov 08, 2023 at 05:48:52PM -0300, Arnaldo Carvalho de Melo escreveu:
> Em Tue, Nov 07, 2023 at 09:37:32AM +0000, James Clark escreveu:
> > On 03/11/2023 15:41, Ian Rogers wrote:
> > > There is also "perf config" for things like this.

> > > Reviewed-by: Ian Rogers <irogers@google.com>

> > That seems a bit better for this use case so I added it in V2.
 
> Have you posted it?

Yeah, b4 found it, nevermind.

- Arnaldo
