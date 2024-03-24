Return-Path: <linux-kernel+bounces-112603-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B9BA887BD5
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 07:00:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 072C228242A
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 06:00:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 233A114286;
	Sun, 24 Mar 2024 06:00:31 +0000 (UTC)
Received: from ms-10.1blu.de (ms-10.1blu.de [178.254.4.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99AF82CA4;
	Sun, 24 Mar 2024 06:00:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.254.4.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711260030; cv=none; b=tmMuFPu3jKr1hzn/j4PZdc7Ns37W1LEoPwBaV3nVEpfd6FS1CgEnmsZROkTfF/YC38FGBJT2fEu6WOk7Mq1i7pD8amsJmygCEBmLsARxvI+n3pYg0t5gXkftsrcucvL4dMO0sGqbS0n+kf5Vt/wr2BRH+i86C1lVx2Ri+psU5ng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711260030; c=relaxed/simple;
	bh=s8cMKpHaAcyyuLqkjUj7usrzSAx6MOM0pJf8hD0ogvY=;
	h=From:Subject:To:Cc:Message-ID:Date:MIME-Version:Content-Type; b=GgkkGPcQ8O182MWwChXj+IcKX05Sr+hrHYYbrD5OJ1pqBWDVJkiCmvJGTKplWQgD29mKd6dtI21BH0a7LtiJX3BcZ/R8a+KhHCFdyxl48iZMqmon1jxrnEooeVwhbhqcmJ2Gpx/CINuMdMqFwk0lYrxnxszpsKbf7hUBNjEj+fU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jsigle.com; spf=pass smtp.mailfrom=jsigle.com; arc=none smtp.client-ip=178.254.4.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jsigle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jsigle.com
Received: from [87.102.202.253] (helo=[192.168.1.64])
	by ms-10.1blu.de with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.95)
	(envelope-from <joerg.sigle@jsigle.com>)
	id 1roGKA-001UXd-CP;
	Sun, 24 Mar 2024 06:23:14 +0100
From: "Joerg M. Sigle" <joerg.sigle@jsigle.com>
Subject: Patch [001/001] Documentation: Correct small errors in recently added
 info on CPU vulnerabilities
Openpgp: preference=signencrypt
Autocrypt: addr=joerg.sigle@jsigle.com; prefer-encrypt=mutual; keydata=
 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
 8PuOAKC9roFUBE+MA3ttuTAdqMIxhIo1cw==
To: Jonathan Corbet <corbet@lwn.net>
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 Dave Hansen <dave.hansen@linux.intel.com>,
 Daniel Sneddon <daniel.sneddon@linux.intel.com>
Message-ID: <ba47d363-28e8-b470-7752-b684e3d05250@jsigle.com>
Date: Sun, 24 Mar 2024 06:23:13 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: de-DE-1901
Content-Transfer-Encoding: 7bit
X-Con-Id: 102464
X-Con-U: 0-joergsigle

From: Joerg-Michael Sigle <joerg.sigle@jsigle.com>

In file     Documentation/admin-guide/hw-vuln/gather_data_sampling.rst
the words   Guest can infer guest from other guests
should be   Guests can infer data from other guests

Found in 15.5.152, this may affect all kernel versions with the same documentation file.
The error came as part of commit 8974eb588283b7d44a7c91fa09fcbaf380339f3a in the master branch.

Signed-off-by: Joerg-Michael Sigle <joerg.sigle@jsigle.com>

---

The corrected text is in section "Attack scenarios", example 4; also visible in the 2nd diff output in:
https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/commit/?id=8974eb588283b7d44a7c91fa09fcbaf380339f3a

I'm submitting this patch to you as you're referenced in that patch
or shown by scripts/get_maintainer.pl -f Documentation/admin-guide/hw-vuln/
Hope this is ok and useful. Thanks & kind regards, Joerg


# diff -ru a/Documentation/admin-guide/hw-vuln/gather_data_sampling.rst b/Documentation/admin-guide/hw-vuln/gather_data_sampling.rst
--- a/Documentation/admin-guide/hw-vuln/gather_data_sampling.rst        2024-03-15 19:30:36.000000000 +0100
+++ b/Documentation/admin-guide/hw-vuln/gather_data_sampling.rst        2024-03-24 06:07:51.847427462 +0100
@@ -32,7 +32,7 @@
        Non-enclaves can infer SGX enclave data
        Userspace can infer kernel data
        Guests can infer data from hosts
-       Guest can infer guest from other guests
+       Guests can infer data from other guests
        Users can infer data from other users

 Because of this, it is important to ensure that the mitigation stays enabled in

