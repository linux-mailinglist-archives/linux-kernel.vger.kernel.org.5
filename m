Return-Path: <linux-kernel+bounces-150910-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 611768AA69C
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 03:43:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E2C641F22DC1
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 01:43:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BCE515D1;
	Fri, 19 Apr 2024 01:43:20 +0000 (UTC)
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF8EE15A4;
	Fri, 19 Apr 2024 01:43:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713490999; cv=none; b=LI8LL0n1ulXrqQE6yTaubOJcfglXEVGv/oiem8kdkT6hRdMYkrZ/WbxcGcz7juw+2LeQ+IqT5+VsXz/aGlYRcI6xNuUKPIXyc5Uvj2Cf/qUSYAIl9QuyIcLmsTcQz5JkBmdw7Db7Xvos/6DIrfosaUDW6efFWmHOU5DOpP2divc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713490999; c=relaxed/simple;
	bh=R/4UYqJsIMAtVhuHTlbZuArGFPMKCeTNMj5pZOQBEfE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=grT8kED9Rl5kDGtaqSNV+cxjLvHE6fZfvfzoAlqpOiV65hcZOiXNVJEov2kTd/UWIKUGNflRuHXsZL8kEai33Fano8sREhmg86D7hnXLlv5LKidO/KBcfCYEmabDnaSH2iD4WQa/47IUyukt8yUOXCpWskMgxPvieS8glKjYJO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [112.20.112.218])
	by gateway (Coremail) with SMTP id _____8AxafAxzCFmZJYpAA--.29170S3;
	Fri, 19 Apr 2024 09:43:13 +0800 (CST)
Received: from [192.168.100.8] (unknown [112.20.112.218])
	by localhost.localdomain (Coremail) with SMTP id AQAAf8BxXRMszCFmhLt_AA--.46410S3;
	Fri, 19 Apr 2024 09:43:10 +0800 (CST)
Message-ID: <92615c41-b17c-49fa-89ba-f7d89adc3a15@loongson.cn>
Date: Fri, 19 Apr 2024 09:43:08 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] docs/zh_CN: add process/cve Chinese translation
To: Dongliang Mu <dzm91@hust.edu.cn>, Alex Shi <alexs@kernel.org>,
 Jonathan Corbet <corbet@lwn.net>,
 Konstantin Ryabitsev <konstantin@linuxfoundation.org>
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240417052804.1957258-1-dzm91@hust.edu.cn>
Content-Language: en-US
From: Yanteng Si <siyanteng@loongson.cn>
In-Reply-To: <20240417052804.1957258-1-dzm91@hust.edu.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:AQAAf8BxXRMszCFmhLt_AA--.46410S3
X-CM-SenderInfo: pvl1t0pwhqwqxorr0wxvrqhubq/
X-Coremail-Antispam: 1Uk129KBj93XoW3WF1kCF1xZF1fWw4xJFWxZrc_yoW3Wr1DpF
	n2kr97ta1xKry3JFWfKr48XF18AFsrCFW3KF1xGa4fJwn5JFZ7twnrX3W5Ww17CryfCa4D
	Xr4vkFW8ury29agCm3ZEXasCq-sJn29KB7ZKAUJUUUUr529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUvGb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
	Gr0_Gr1UM2kKe7AKxVWUXVWUAwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07AIYI
	kI8VC2zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUXVWU
	AwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI48JMx
	AIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMxCIbckI1I0E14v26r1Y6r17
	MI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67
	AKxVWUAVWUtwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0
	cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z2
	80aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVWUJVW8JbIYCTnIWIevJa73UjIF
	yTuYvjxU2MKZDUUUU


在 2024/4/17 13:27, Dongliang Mu 写道:
> Translate process/cve.rst into Chinese and add it to
> Documentation/translations/zh_CN directory.
>
> Signed-off-by: Dongliang Mu <dzm91@hust.edu.cn>
> ---
>   .../translations/zh_CN/process/cve.rst        | 89 +++++++++++++++++++
>   .../translations/zh_CN/process/index.rst      |  1 +
>   2 files changed, 90 insertions(+)
>   create mode 100644 Documentation/translations/zh_CN/process/cve.rst
>
> diff --git a/Documentation/translations/zh_CN/process/cve.rst b/Documentation/translations/zh_CN/process/cve.rst
> new file mode 100644
> index 000000000000..c1e50d0b61e3
> --- /dev/null
> +++ b/Documentation/translations/zh_CN/process/cve.rst
> @@ -0,0 +1,89 @@
> +.. include:: ../disclaimer-zh_CN.rst
> +
> +:Original: Documentation/process/cve.rst
> +:Translator: Dongliang Mu <dzm91@hust.edu.cn>
> +
> +====
> +CVEs
> +====
> +
> +Common Vulnerabilities and Exposure (CVE®) 编号是一种明确的方式来
> +识别、定义和登记公开披露的安全漏洞。随着时间的推移，它们在内核项目中的实用性
> +已经下降，CVE编号经常以不适当的方式和不适当的原因被分配。因此，内核开发社区
> +倾向于避免使用它们。然而，分配CVE与其他形式的安全标识符的持续压力，以及内核
> +社区之外的个人和公司的持续滥用，已经清楚地表明内核社区应该控制这些CVE分配。
> +
> +Linux内核开发团队确实有能力为潜在的Linux内核安全问题分配CVE。CVE的分配
> +独立于 :doc:`安全漏洞报送流程</process/security-bugs>`。
> +
> +所有分配给Linux内核的CVE列表都可以在linux-cve邮件列表的存档中找到，如
> +https://lore.kernel.org/linux-cve-announce/ 所示。如果想获得已分配
> +CVE的通知，请“订阅”该邮件列表。要获得分配的CVE通知，请订阅该邮件列表：
> +`subscribe <https://subspace.kernel.org/subscribing.html>`_。
> +
> +过程
> +=======
> +
> +作为正常稳定发布过程的一部分，可能存在安全问题的内核更改由负责CVE编号分配
> +的开发人员识别，并自动为其分配CVE编号。这些CVE分配会作为经常性的通告经常
> +发布在linux-cve-announce邮件列表上。
> +
> +注意，由于Linux内核在系统中的特殊地位，几乎任何漏洞都可能被利用来危害内核
> +的安全性，但是当漏洞被修复后，利用的可能性通常不明显。因此，CVE分配团队过于
> +谨慎，并将CVE编号分配给他们识别的任何漏洞修复。这就解释了为什么Linux内核
> +团队会发布大量的CVE。
> +
> +如果CVE分配团队错过了任何用户认为应该分配CVE的特定修复，请发送电子邮件到
> +<cve@kernel.org>，那里的团队将与您一起工作。请注意，任何潜在的安全问题
> +不应被发送到此邮箱，它仅用于为已发布的内核树中的漏洞修复分配CVE。如果你觉得
> +自己发现了一个未修复的安全问题，请按照 :doc:`安全漏洞报送流程
> +</process/security-bugs>` 发送到Linux内核社区。
> +
> +Linux内核不会给未修复的安全问题自动分配CVE；只有在安全修复可用且应用于
> +稳定内核树后，CVE分配才会自动发生，并且它将通过安全修复的Git提交编号进行
> +跟踪。如果有人希望在提交安全修复之前分配CVE，请联系内核CVE分配团队，从
> +他们的一批保留编号中获得相应的CVE编号。
> +
> +对于目前没有得到稳定与长期维护内核团队积极支持的内核版本中发现的任何问题，
> +都不会分配CVEs。当前支持的内核分支列表可以在 https://kernel.org/releases.html
> +上找到。
> +
> +被分配CVE的争论
> +=========================
> +
> +对于为特定内核修改分配的CVE，其争论或修改的权限仅属于受影响子系统的维护者。
> +这一原则确保了漏洞报告的高度准确性和可问责性。只有那些具有深厚专业知识和
> +对子系统深入了解的维护人员，才能有效评估内核漏洞的有效性和范围，并确定其适当的
> +CVE指定策略。在此指定权限之外，任何争论或修改CVE的尝试都可能导致混乱、
> +不准确的报告，并最终危及系统。
> +
> +无效的CVE
> +============
> +
> +如果发现的安全问题存在于仅由某Linux发行版支持的Linux内核中，即安全问题是
> +由于Linux发行版所做的更改导致，或者Linux的发行版内核版本不再是Linux内核
> +社区支持的内核版本，那么Linux内核CVE团队将不能分配CVE，必须从Linux
> +发行版本身请求。
> +
> +内核CVE分配团队以外的任何团队对Linux内核支持版本分配的CVE都不应被
> +视为有效CVE。请通知内核CVE分配团队，以便他们可以通过CNA修复过程使
> +这些条目失效。
> +
> +特定CVE的适用性
> +==============================
> +
> +由于Linux内核可以以许多不同方式使用，外部用户可以通过许多不同方式访问它，或者
> +根本没有访问，因此任何特定CVE的适用性取决于Linux用户，而不是内核CVE分配团队。
> +请不要与我们联系来尝试确定任何特定CVE的适用性。
> +
> +此外，由于源代码树非常大，而任何一个系统都只使用源代码树的一小部分，因此任何
> +Linux用户都应该意识到，大量分配的CVEs与他们的系统无关。
> +
> +简而言之，我们不知道您的用例，也不知道您使用的是内核的哪个部分，因此我们无法
> +确定特定的CVE是否与您的系统相关。
> +
> +与往常一样，最好采取所有发布的内核更改，因为它们是由许多社区成员在一个统一的
> +整体中一起进行测试的，而不是作为个别的精选更改。还要注意，对于许多安全问题来
> +说，整体问题的解决方案并不是在单个更改中找到的，而是在彼此之上的许多修复的总
> +和。理想情况下，CVE将被分配给所有问题的所有修复，但有时我们将无法注意到一些
> +修复，因此某些修复可能在没有CVE的情况下被采取。
> \ No newline at end of file

We need a blank line here.


Thanks,

Yanteng

> diff --git a/Documentation/translations/zh_CN/process/index.rst b/Documentation/translations/zh_CN/process/index.rst
> index 3ca02d281be0..5c6c8ccdd50d 100644
> --- a/Documentation/translations/zh_CN/process/index.rst
> +++ b/Documentation/translations/zh_CN/process/index.rst
> @@ -48,6 +48,7 @@ TODOLIST:
>      :maxdepth: 1
>   
>      embargoed-hardware-issues
> +   cve
>   
>   TODOLIST:
>   


